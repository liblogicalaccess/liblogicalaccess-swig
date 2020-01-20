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
    /**
     * This was a test to check that native C++ code can call into C# overriden
     * method.
     *
     * However it only works with multiple LLA workaround.
     * SWIG has issues with director and non-public method
     * with default parameters...
     */
    public class SimpleReaderUnit : PCSCReaderUnit
    {
        public SimpleReaderUnit(string name) : base(name)
        {
        }

        /**
         * Will be called by native C++ code.
         */
        public override void disconnect()
        {
            hasBeenCalled = true;
            base.disconnect();
        }
        
        public bool hasBeenCalled = false;
    }

    public class CustomDataTransport : DummyDataTransport
    {
        
    }

    [TestClass]
    public class CallBackReaderUnitTest
    {
        // This test doesnt work because PCSCReaderUnit is not a director.
        // PCSCReaderUnit is not a director because SWIG codegen issues.
        [TestMethod]
        public void SimpleReaderUnitTest()
        {
            var readerConfig = new ReaderConfiguration();
            readerConfig.setReaderProvider(
                LibraryManager.getInstance().getReaderProvider("PCSC"));
            ReaderUnitVector readers =
                readerConfig.getReaderProvider().getReaderList();
            readerConfig.setReaderUnit(readers[0]);
            Assert.IsTrue(readers.Count > 0);
            ReaderUnit ru = readers[0];
            ReaderUnit r2 = new SimpleReaderUnit(ru.getName());
            SimpleReaderUnit r2simple = r2 as SimpleReaderUnit;
            r2.setReaderProvider(new ReaderProviderWeakPtr(ru.getReaderProvider()));
            r2.setConfiguration(ru.getConfiguration());
            r2.setDataTransport(ru.getDataTransport());
            r2.setDefaultReaderCardAdapter(ru.getDefaultReaderCardAdapter());
            bool typeA = true;
            bool typeB = false;
            Console.WriteLine("Cool: " + typeA + ". B: " + typeB);
            r2simple.getT_CL_ISOType(ref typeA, ref typeB);
            Console.WriteLine("Cool: " + typeA + ". B: " + typeB);
            r2.connectToReader();
            r2.waitInsertion(1000);

            // Double connect. LLA code should call disconnect() internally.
            // Yes, this test relies on LLA implementation details, but well...
            r2.connect();
            r2.connect();
            r2simple.getT_CL_ISOType(ref typeA, ref typeB);
            Console.WriteLine("Cool: " + typeA + ". B: " + typeB);
            r2.disconnectFromReader();
            Assert.IsTrue(r2simple.hasBeenCalled);
        }
    }
}