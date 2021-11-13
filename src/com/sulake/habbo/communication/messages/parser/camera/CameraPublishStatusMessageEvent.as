package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CameraPublishStatusMessageEvent extends MessageEvent 
    {

        public function CameraPublishStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CameraPublishStatusMessageParser);
        }

        public function getParser():CameraPublishStatusMessageParser
        {
            return (this._SafeStr_816 as CameraPublishStatusMessageParser);
        }


    }
}

