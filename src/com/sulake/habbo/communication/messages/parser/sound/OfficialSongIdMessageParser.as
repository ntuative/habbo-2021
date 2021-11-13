package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OfficialSongIdMessageParser implements IMessageParser 
    {

        private var _songId:int;
        private var _officialSongId:String;


        public function flush():Boolean
        {
            _songId = 0;
            _officialSongId = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _officialSongId = _arg_1.readString();
            _songId = _arg_1.readInteger();
            return (true);
        }

        public function get songId():int
        {
            return (_songId);
        }

        public function get officialSongId():String
        {
            return (_officialSongId);
        }


    }
}