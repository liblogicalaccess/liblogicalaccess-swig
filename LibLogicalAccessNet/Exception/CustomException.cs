using System;
using System.Collections.Generic;
using System.Text;

namespace swig
{
    class CustomException : global::System.Exception
    {
        public CustomException()
        {
        }

        public CustomException(string message)
            : base(message)
        {
        }

        public CustomException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
