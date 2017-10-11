using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;

namespace Mifare1KTests
{
    [TestClass]
    public class TestIterateMemory : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.Write("This test target Mifare1K cards.");

            Debug.Write("You will have 20 seconds to insert a card. Test log below");
            Debug.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.Write("TESTS LIST: ");
        }

        //[TestMethod]
        public void IterateMemoryTests()
        {
            LLANTestInit();

            LocationNode rootNode = chip.getRootLocationNode();
            LocationNodePtrCollection children = rootNode.getChildrens();
            int size = 0;
            foreach (var child in children)
            {
                int tmp_size = (int)(child.getLength() * child.getUnit());
                Console.WriteLine("Size of node " + child.getName() + ": " + tmp_size + " bytes");
                size += tmp_size;
            }
            Assert.AreEqual(children.Count, 16, "Unexpected number of children");
            Assert.AreEqual(size, 768, "Memory size unexpected");
        }
    }
}
