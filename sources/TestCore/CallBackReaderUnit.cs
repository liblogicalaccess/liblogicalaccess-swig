using LibLogicalAccess;
using LibLogicalAccess.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestCore
{
    public class CallBackReaderUnit : OmnikeyReaderUnit
    {
        public CallBackReaderUnit(string rpt) : base(rpt)
        {
        }

        public void test()
        {
            reconnect(1);
        }

        public override Chip getSingleChip()
        {
            Console.WriteLine("COUCOU LES COPAINS");
            return null;
        }
    }

    public class SimpleReaderUnit : PCSCReaderUnit
    {
        public SimpleReaderUnit(string name) : base(name)
        {
        }

        public override void disconnect()
        {
            hasBeenCalled = true;
            base.disconnect();
        }

        public void callMe()
        {
        }

        public bool hasBeenCalled = false;
    }


    [TestClass]
    public class CallBackReaderUnitTest
    {
        [TestMethod]
        public void CallBackReaderUnit_Test()
        {
            //var ru = new CallBackReaderUnit("lol");
            // ru.test();
        }

        [TestMethod]
        public void SimpleReaderUnitTest()
        {
            var readerConfig = new ReaderConfiguration();
            readerConfig.setReaderProvider(
                LibraryManager.getInstance().getReaderProvider("PCSC"));
            ReaderUnitVector readers =
                readerConfig.getReaderProvider().getReaderList();
            Console.WriteLine("Please select index of the reader unit to use:");
            for (int x = 0; x < readers.Count(); ++x)
            {
                Console.WriteLine("\t" + readers[x].getName());
            }

            readerConfig.setReaderUnit(readers[0]);

            ReaderUnit ru = readers[0];

            ReaderUnit r2 = new SimpleReaderUnit(ru.getName());
            SimpleReaderUnit r2simple = r2 as SimpleReaderUnit;
            r2.setReaderProvider(new ReaderProviderWeakPtr(ru.getReaderProvider()));
            r2.setConfiguration(ru.getConfiguration());
            r2.setDataTransport(ru.getDataTransport());
            r2.setDefaultReaderCardAdapter(ru.getDefaultReaderCardAdapter());

            r2.connectToReader();
            r2.waitInsertion(1000);
            r2.connect();
            
            r2.disconnect();
            r2.disconnectFromReader();

            Assert.IsTrue(r2simple.hasBeenCalled);
        }
    }
}