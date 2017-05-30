using LibLogicalAccess;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibLogicalAccessTest
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                LibraryManager manager = LibraryManager.getInstance();

                // Explicitly use the PC/SC Reader Provider.
                ReaderProvider readerProvider = manager.getReaderProvider("PCSC");

                // Create the default reader unit. On PC/SC, we will listen on all readers.
                ReaderUnit readerUnit = readerProvider.createReaderUnit();

                ReaderUnitVector readerList = readerProvider.getReaderList();
                if (readerProvider.getRPType() == "PCSC" && readerList.Count == 0)
                {
                    Console.WriteLine("No readers on this system.");
                    Environment.Exit(1);
                }
                Console.WriteLine("{0} readers on this system.", readerList.Count);

                if (readerUnit.connectToReader())
                {
                    Console.WriteLine("Waiting 15 seconds for a card insertion...");
                    if (readerUnit.waitInsertion(15000))
                    {
                        if (readerUnit.connect())
                        {
                            Console.WriteLine("Card inserted on reader '{0}.'", readerUnit.getConnectedName());

                            Chip chip = readerUnit.getSingleChip();
                            Console.WriteLine("\tCSN: {0}", UCharCollectionToHexString(chip.getChipIdentifier()));
                            Console.WriteLine("\tChip Name: {0}", chip.getCardType());

                            LibLogicalAccess.Reader.PCSCDataTransport.CheckCardError(1);

                            readerUnit.disconnect();
                        }

                        Console.WriteLine("Logical automatic card removal in 15 seconds...");
                        if (!readerUnit.waitRemoval(15000))
                        {
                            Console.WriteLine("Card removal forced.");
                        }

                        Console.WriteLine("Card removed.");
                    }
                    else
                    {
                        Console.WriteLine("No card inserted.");
                    }

                    readerUnit.disconnectFromReader();
                }
                else
                {
                    Console.WriteLine("Unable to connect to the reader");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error : {0} - {1}", ex, ex.Message);
            }

            Console.ReadLine();
        }

        static string UCharCollectionToHexString(UByteVector uchars)
        {
            string str = String.Empty;
            foreach (byte b in uchars)
            {
                str += b.ToString("X2");
            }
            return str;
        }
    }
}
