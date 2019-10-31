@Library("islog-helper") _

pipeline {
    agent {
        node {
            label 'win2016'
            customWorkspace "lla-swig"
        }
    }

    options {
        gitLabConnection('Gitlab Pontos')
    }

    triggers {
        gitlab(
                triggerOnPush: true,
                triggerOnMergeRequest: true,
                branchFilterType: 'All',
        )
    }

    environment {
        CONAN_REVISIONS_ENABLED = 1
        PACKAGE_NAME = "LogicalAccessSwig/2.1.0@islog/develop"
    }

    stages {
        stage('Full Swig') {
            parallel {
                stage("Linux Swig") {
                    stages {
                        stage('Linux Swig Support Container') {
                            agent { label 'linux' }
                            steps {
                                sh "docker build --pull -t docker-registry.islog.com:5000/swig-support:latest -f Dockerfile ."
                                sh "docker push docker-registry.islog.com:5000/swig-support:latest"
                            }
                        }

                        // Only x64 release
                        stage('Linux Swig') {
                            agent {
                                docker 'docker-registry.islog.com:5000/swig-support:latest'
                            }
                            steps {
                                script {
                                    conan.withFreshWindowsConanCache {
                                        sh "./linux.sh"
                                        dir('sources/LibLogicalAccessNet.win32') {
                                            sh "mkdir build"
                                            dir('build') {
                                                sh 'conan install -p compilers/x64_gcc6_release -u ..'
                                                sh 'conan build ..'
                                                sh 'conan package ..'
                                                sh "conan export-pkg --profile compilers/x64_gcc6_release .. ${PACKAGE_NAME}"
                                                sh "conan upload ${PACKAGE_NAME} -r islog-test --all --confirm --check --force"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                stage('Window Swig') {
                    stages {
                        stage('Pre-Build') {
                            steps {
								echo "NODE_NAME = ${env.NODE_NAME}"
                                deleteDir()
                                checkout scm

                                script {
                                    conan.withFreshWindowsConanCache {
                                        powershell 'islog-prebuild'
                                    }
                                }

                                dir('sources/scripts') {
                                    bat 'pip install -r requirements.txt'
                                }
                            }
                        }

                        stage('Generate SWIG') {
                            steps {
								echo "NODE_NAME = ${env.NODE_NAME}"
                                // gitversion do not support vs2017 project for now https://github.com/GitTools/GitVersion/issues/1315
                                powershell 'sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj'
                                powershell 'sources/scripts/generate-swig.ps1'
                            }
                        }

                        stage('Build') {
                            steps {
								echo "NODE_NAME = ${env.NODE_NAME}"
                                dir('sources') {
                                    powershell 'islog-build 0 Release'
                                }
                                dir('sources/LibLogicalAccessNet.win32') {
                                    script {
                                        conan.withFreshWindowsConanCache {
                                            powershell './conan-build.ps1 -publish 1'
                                        }
                                    }
                                }
                                warnings canComputeNew: false, canResolveRelativePaths: false, categoriesPattern: '', consoleParsers: [[parserName: 'MSBuild']], defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', messagesPattern: '', unHealthy: ''
                            }
                        }

                        stage('Package') {
                            steps {
								echo "NODE_NAME = ${env.NODE_NAME}"
                                powershell 'islog-sign'
                                powershell 'islog-package'
                            }
                        }

                        stage('Publish') {
                            steps {
								echo "NODE_NAME = ${env.NODE_NAME}"
                                powershell 'islog-publish sources/LibLogicalAccessNet.win32/bin $false $true'
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        failure {
            updateGitlabCommitStatus name: 'build', state: 'failed'
        }
        success {
            updateGitlabCommitStatus name: 'build', state: 'success'
        }
        unstable {
            updateGitlabCommitStatus name: 'build', state: 'success'
        }

        changed {
            script {
                if (currentBuild.currentResult == 'FAILURE' || currentBuild.currentResult == 'SUCCESS') {
                    // Other values: SUCCESS, UNSTABLE
                    // Send an email only if the build status has changed from green/unstable to red
                    emailext subject: '$DEFAULT_SUBJECT',
                            body: '$DEFAULT_CONTENT',
                            recipientProviders: [
                                    [$class: 'CulpritsRecipientProvider'],
                                    [$class: 'DevelopersRecipientProvider'],
                                    [$class: 'RequesterRecipientProvider']
                            ],
                            replyTo: 'cis@islog.com',
                            to: 'reports@islog.com'
                }
            }
        }
    }
}