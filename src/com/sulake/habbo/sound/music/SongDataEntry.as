package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.IHabboSound;

    public class SongDataEntry extends PlayListEntry implements ISongInfo 
    {

        private var _soundObject:IHabboSound = null;
        private var _songData:String;
        private var _diskId:int = -1;

        public function SongDataEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:IHabboSound)
        {
            _soundObject = _arg_5;
            _songData = "";
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function get id():int
        {
            return (_SafeStr_1789);
        }

        override public function get length():int
        {
            return (_SafeStr_1844);
        }

        override public function get name():String
        {
            return (_songName);
        }

        override public function get creator():String
        {
            return (_SafeStr_1845);
        }

        public function get loaded():Boolean
        {
            return ((_soundObject == null) ? false : _soundObject.ready);
        }

        public function get soundObject():IHabboSound
        {
            return (_soundObject);
        }

        public function get songData():String
        {
            return (_songData);
        }

        public function get diskId():int
        {
            return (_diskId);
        }

        public function set soundObject(_arg_1:IHabboSound):void
        {
            _soundObject = _arg_1;
        }

        public function set songData(_arg_1:String):void
        {
            _songData = _arg_1;
        }

        public function set diskId(_arg_1:int):void
        {
            _diskId = _arg_1;
        }


    }
}

