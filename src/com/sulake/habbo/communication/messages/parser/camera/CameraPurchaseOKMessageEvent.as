package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CameraPurchaseOKMessageEvent extends MessageEvent 
    {

        public function CameraPurchaseOKMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CameraPurchaseOKMessageParser);
        }

        public function getParser():CameraPurchaseOKMessageParser
        {
            return (this._SafeStr_816 as CameraPurchaseOKMessageParser);
        }


    }
}

