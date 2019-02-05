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
    public class TestIncrement : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.Write("This test target Mifare1K cards.");

            Debug.Write("You will have 20 seconds to insert a card. Test log below");
            Debug.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.Write("TESTS LIST: ");
        }

        private void ReadValueBlock(MifareCommands cmd)
        {
            var key = new MifareKey("ff ff ff ff ff ff");
            cmd.loadKey(0, MifareKeyType.KT_KEY_A, key);
            int value;
            byte backup;

            cmd.authenticate(32, 0, MifareKeyType.KT_KEY_A);
            cmd.readValueBlock(32, out value, out backup);
            Assert.AreEqual(value, 42424242, "Invalid value");
            Assert.AreEqual(backup, 17, "Invalid backup block number");
        }

        private void WriteValueBlock(MifareCommands cmd)
        {
            var key = new MifareKey("ff ff ff ff ff ff");
            cmd.loadKey(0, MifareKeyType.KT_KEY_A, key);

            cmd.authenticate(32, 0, MifareKeyType.KT_KEY_A);
            cmd.writeValueBlock(32, 42424242, 33);

            cmd.authenticate(16, 0, MifareKeyType.KT_KEY_A);
            cmd.writeValueBlock(16, -42, 17);
        }

        private void Increment(MifareCommands cmd)
        {
            var key = new MifareKey("ff ff ff ff ff ff");
            cmd.loadKey(0, MifareKeyType.KT_KEY_A, key);
            int value;
            byte backup;

            cmd.authenticate(32, 0, MifareKeyType.KT_KEY_A);
            cmd.increment(32, 10);
            cmd.readValueBlock(32, out value, out backup);
            Assert.AreEqual(value, 42424252, "Invalid value");

            cmd.authenticate(16, 0, MifareKeyType.KT_KEY_A);
            cmd.increment(16, 84);
            cmd.readValueBlock(16, out value, out backup);
            Assert.AreEqual(value, 42, "Invalid value");
        }

        private void Decrement(MifareCommands cmd)
        {
            var key = new MifareKey("ff ff ff ff ff ff");
            cmd.loadKey(0, MifareKeyType.KT_KEY_A, key);
            int value;
            byte backup;

            cmd.authenticate(32, 0, MifareKeyType.KT_KEY_A);
            cmd.decrement(32, 20);
            cmd.readValueBlock(32, out value, out backup);
            Assert.AreEqual(value, 42424232, "Invalid value");

            cmd.authenticate(16, 0, MifareKeyType.KT_KEY_A);
            cmd.increment(16, 84 + 42);
            cmd.readValueBlock(16, out value, out backup);
            Assert.AreEqual(value, -84, "Invalid value");
        }

        //[TestMethod]
        public void IncrementTests(string[] arg)
        {
            LLATestInit("Mifare1K");

            Assert.AreEqual(chip.getCardType(), "Mifare1K", "Chip is not a Mifare1K, but is " + chip.getCardType() + " instead.");

            var cmd = chip.getCommands() as MifareCommands;

            LocationNode rootNode = chip.getRootLocationNode();
            LocationNodePtrCollection childs = rootNode.getChildrens();

            WriteValueBlock(cmd);
            ReadValueBlock(cmd);
            Increment(cmd);
            Decrement(cmd);
        }
    }
}
