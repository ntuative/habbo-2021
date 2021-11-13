package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementResolutionCompletedMessageParser implements IMessageParser 
    {

        private var _stuffCode:String;
        private var _badgeCode:String;


        public function flush():Boolean
        {
            _stuffCode = "";
            _badgeCode = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _stuffCode = _arg_1.readString();
            _badgeCode = _arg_1.readString();
            return (true);
        }

        public function get stuffCode():String
        {
            return (_stuffCode);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }


    }
}