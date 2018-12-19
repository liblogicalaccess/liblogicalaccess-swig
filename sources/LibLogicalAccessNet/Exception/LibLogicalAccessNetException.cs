using System;
using System.Collections.Generic;
using System.Text;

namespace LibLogicalAccess
{
    public class LibLogicalAccessNetException : global::System.Exception
    {
        public LibLogicalAccessNetException()
        {
        }

        public LibLogicalAccessNetException(string message)
            : base(message)
        {
        }

        public LibLogicalAccessNetException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
