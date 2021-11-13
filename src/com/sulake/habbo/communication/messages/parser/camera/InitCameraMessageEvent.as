package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class InitCameraMessageEvent extends MessageEvent 
    {

        public function InitCameraMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InitCameraMessageParser);
        }

        public function getParser():InitCameraMessageParser
        {
            return (this._SafeStr_816 as InitCameraMessageParser);
        }


    }
}

