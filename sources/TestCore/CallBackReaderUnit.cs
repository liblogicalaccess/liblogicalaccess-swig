using LibLogicalAccess;
using LibLogicalAccess.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestCore
{
    public class CallBackReaderUnit : ISO7816ReaderUnit
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


    [TestClass]
    public class CallBackReaderUnitTest
    {
        [TestMethod]
        public void CallBackReaderUnit_Test()
        {
            var ru = new CallBackReaderUnit("lol");
            ru.test();
        }
    }
}
