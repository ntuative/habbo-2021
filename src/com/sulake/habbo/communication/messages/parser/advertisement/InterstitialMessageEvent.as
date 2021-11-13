package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class InterstitialMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InterstitialMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InterstitialMessageParser);
        }

        public function getParser():InterstitialMessageParser
        {
            return (this._SafeStr_816 as InterstitialMessageParser);
        }


    }
}

