package com.sulake.habbo.communication.messages.parser.room.camera
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CameraSnapshotMessageEvent extends MessageEvent 
    {

        public function CameraSnapshotMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CameraSnapshotMessageParser);
        }

        public function getParser():CameraSnapshotMessageParser
        {
            return (_SafeStr_816 as CameraSnapshotMessageParser);
        }


    }
}

