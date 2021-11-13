package com.sulake.habbo.communication.messages.parser.error
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ErrorReportEvent extends MessageEvent implements IMessageEvent 
    {

        public function ErrorReportEvent(_arg_1:Function)
        {
            super(_arg_1, ErrorReportMessageParser);
        }

        public function getParser():ErrorReportMessageParser
        {
            return (this._SafeStr_816 as ErrorReportMessageParser);
        }


    }
}

