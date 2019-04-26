using System;
using System.Collections.Generic;
using System.Text;
using LibLogicalAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestCore
{
    [TestClass]
    public class IKS
    {
        [TestMethod]
        public void IKSStorage_test()
        {
            var iksstorage = new IKSStorage();
            iksstorage.setIKSConfig("127.0.0.1", 12, "MyClientCertPath", "MyClientKeyPath", "MyRootCAPath");
            var tmp = iksstorage.getIKSConfig();
            
            Assert.AreEqual("127.0.0.1", tmp.ip);
            Assert.AreEqual("MyClientCertPath", tmp.client_cert);
            Assert.AreEqual("MyClientKeyPath", tmp.client_key);
            Assert.AreEqual("MyRootCAPath", tmp.root_ca);
        }
    }
}
