using System;
using System.Text;
using LibLogicalAccess;
using LibLogicalAccess.Reader;
using LibLogicalAccess.Card;

/*
 ************************************************************************
 *                                                                      *
 *  LibLogicalAccess RFID library basic sample in DotNet (C#).          *
 *  It's the same code design in Delphi and Visual Basic.               *
 *  The C++ native version is compliant with Windows and Linux          *
 *                                                                      *
 ************************************************************************
*/

namespace basic
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

                ReaderUnitCollection readerList = readerProvider.getReaderList();
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

                            PCSCReaderUnit pcscru = readerUnit as PCSCReaderUnit;
                            if (pcscru != null)
                            {
                                pcscru.getPCSCType();
                            }


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
                Console.WriteLine("Error : {0}", ex.Message);
            }

            Console.ReadLine();
        }

        static string UCharCollectionToHexString(UCharCollection uchars)
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
