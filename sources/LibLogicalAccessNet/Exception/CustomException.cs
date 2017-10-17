using System;
using System.Collections.Generic;
using System.Text;

namespace LibLogicalAccess
{
    public abstract class CustomException : global::System.Exception
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

        public override string Message
        {
            get
            {
                return what();
            }
        }

        public virtual string what()
        {
            return null;
        }
    }
}
