package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserGameAchievementsMessageParser implements IMessageParser 
    {

        private var _gameTypeId:int;
        private var _SafeStr_1999:AchievementsMessageParser;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _gameTypeId = _arg_1.readInteger();
            _SafeStr_1999 = new AchievementsMessageParser();
            _SafeStr_1999.parse(_arg_1);
            return (true);
        }

        public function get gameTypeId():int
        {
            return (_gameTypeId);
        }

        public function get achievements():Array
        {
            return (_SafeStr_1999.achievements);
        }

        public function get defaultCategory():String
        {
            return (_SafeStr_1999.defaultCategory);
        }


    }
}

