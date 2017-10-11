using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;

namespace EPassTests
{
    [TestClass]
    public class Dump : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("Dump some information about an EPassport.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        }

        [TestMethod]
        public void DumpTest()
        {
            LLANTestInit();

            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual("EPass", chip.getCardType(), "Chip is not an EPass, but is " + chip.getCardType() + " instead.");

            var srv = chip.getService(CardServiceType.CST_IDENTITY) as IdentityCardService;
            Assert.IsNotNull(srv, "Cannot retrieve identity service from the chip");
            /* Impossible to translate this C++ unit test into C# since it needs an answer on the standard input
            // Prepare the service.
            var ai =  new EPassAccessInfo();
            string mrz;
            Debug.WriteLine("Enter MRZ please: ");
            srv->setAccessInfo(ai);

            std::string name = srv->getString(IdentityCardService::MetaData::NAME);
            PRINT_TIME("Name: " + name);

            std::string nationality = srv->getString(IdentityCardService::MetaData::NATIONALITY);
            PRINT_TIME("Country: " + nationality);

            std::string docno = srv->getString(IdentityCardService::MetaData::DOC_NO);
            PRINT_TIME("Docno: " + docno);

            std::chrono::system_clock::time_point tp = srv->getTime(IdentityCardService::MetaData::BIRTHDATE);
            std::time_t tp_t = std::chrono::system_clock::to_time_t(tp);
            std::tm tm = *std::localtime(&tp_t);

            char buff[512];
            std::strftime(buff, sizeof(buff), "%c", &tm);
            PRINT_TIME("Birthdate: " << buff);

            ByteVector picture_data = srv->getData(IdentityCardService::MetaData::PICTURE);
            {
                std::ofstream of("/tmp/passport_pic.jpeg");
                of.write((const char*)picture_data.data(), picture_data.size());
            }
            PRINT_TIME("Photo was dumped into: /tmp/passport_pic.jpeg");

            pcsc_test_shutdown(readerUnit);

            return EXIT_SUCCESS;
            */
        }
    }
}
