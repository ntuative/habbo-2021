package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class ThumbnailStatusMessageEvent extends MessageEvent 
    {

        public function ThumbnailStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ThumbnailStatusMessageParser);
        }

        public function getParser():ThumbnailStatusMessageParser
        {
            return (this._SafeStr_816 as ThumbnailStatusMessageParser);
        }


    }
}

