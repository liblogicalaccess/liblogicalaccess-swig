using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;
using System.Collections.Generic;
using System.Linq;

namespace DESFireEV1Tests
{
    [TestClass]
    public class TestFormat
    {
        [TestMethod]
        public void General()
        {
            Debug.WriteLine("Start format... ");
            foreach (FormatType type in Enum.GetValues(typeof(FormatType)))
            {
               Format format = Format.getByFormatType(type);

                switch (type)
                {
                    case FormatType.FT_ASCII:
                        if (!(format is ASCIIFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_BARIUM_FERRITE_PCSC:
                        if (!(format is BariumFerritePCSCFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND35:
                        if (!(format is Wiegand35Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_CUSTOM:
                        if (!(format is CustomFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_DATACLOCK:
                        if (!(format is DataClockFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_FASCN200BIT:
                        if (!(format is FASCN200BitFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_GETRONIK40BIT:
                        if (!(format is Getronik40BitFormat))
                            throw new Exception("Wrong format");
                        break;

                    case FormatType.FT_HIDHONEYWELL:
                        if (!(format is HIDHoneywell40BitFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_RAW:
                        if (!(format is RawFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND26:
                        if (!(format is Wiegand26Format))
                            throw new Exception("Wrong format");
                        break;

                    case FormatType.FT_WIEGAND34:
                        if (!(format is Wiegand34Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND34FACILITY:
                        if (!(format is Wiegand34WithFacilityFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND37:
                        if (!(format is Wiegand37Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND37FACILITY:
                        if (!(format is Wiegand37WithFacilityFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_UNKNOWN:
                        if (format != null)
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGANDFLEXIBLE: 
                        break; //No used
                    default:
                        throw new Exception("Unknown format");
                }


            }
            Debug.WriteLine("End format test");
        }
    }
}
