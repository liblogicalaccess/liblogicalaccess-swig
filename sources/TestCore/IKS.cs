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
            string ip;
            ushort port;
            string clientCertPath;
            string clientKeyPath;
            string rootCAPath;
            var tmp = iksstorage.getIKSConfig();
            iksstorage.getIKSConfig(out ip, out port, out clientCertPath, out clientCertPath, out rootCAPath);
        }
    }
}
