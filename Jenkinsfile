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

    stages {
        stage('Pre-Build') {
            steps {
                deleteDir()
                checkout scm;
				
				dir('installer') {
					script {
						conan.withFreshWindowsConanCache {
							bat 'conan-imports.bat'
						}
					}
				}
                dir('sources/scripts') {
                    bat 'pip install -r requirements.txt'
                }
			}
		}
		
		stage('Generate SWIG') {
			steps {
                // gitversion do not support vs2017 project for now https://github.com/GitTools/GitVersion/issues/1315
                powershell 'sources/scripts/update-gitversion-vs2017proj.ps1 sources/LibLogicalAccessNet/LibLogicalAccessNet.csproj'
                powershell 'sources/scripts/generate-swig.ps1'
			}
		}
		
		stage('Build') {
			steps {
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
                powershell 'islog-sign'
                powershell 'islog-package'
            }
        }

        stage('Publish') {
            steps {
                powershell 'islog-publish sources/LibLogicalAccessNet.win32/bin $false $true'
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