package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CameraStorageUrlMessageEvent extends MessageEvent 
    {

        public function CameraStorageUrlMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CameraStorageUrlMessageParser);
        }

        public function getParser():CameraStorageUrlMessageParser
        {
            return (this._SafeStr_816 as CameraStorageUrlMessageParser);
        }


    }
}

