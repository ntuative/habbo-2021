package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GameLobbyPlayerData 
    {

        public static var _SafeStr_339:Function = comparePlayersByTotalScore;
        public static var _SafeStr_340:Function = comparePlayersBySkillLevel;

        private var _userId:int;
        private var _name:String;
        private var _figure:String;
        private var _gender:String;
        private var _teamId:int;
        private var _skillLevel:int;
        private var _totalScore:int;
        private var _scoreToNextLevel:int;

        public function GameLobbyPlayerData(_arg_1:IMessageDataWrapper)
        {
            _userId = _arg_1.readInteger();
            _name = _arg_1.readString();
            _figure = _arg_1.readString();
            _gender = _arg_1.readString();
            _teamId = _arg_1.readInteger();
            _skillLevel = _arg_1.readInteger();
            _totalScore = _arg_1.readInteger();
            _scoreToNextLevel = _arg_1.readInteger();
        }

        private static function comparePlayersByTotalScore(_arg_1:GameLobbyPlayerData, _arg_2:GameLobbyPlayerData):Number
        {
            var _local_3:int = _arg_1.totalScore;
            var _local_4:int = _arg_2.totalScore;
            if (_local_3 < _local_4)
            {
                return (1);
            };
            if (_local_3 == _local_4)
            {
                return (0);
            };
            return (-1);
        }

        private static function comparePlayersBySkillLevel(_arg_1:GameLobbyPlayerData, _arg_2:GameLobbyPlayerData):Number
        {
            var _local_4:int = _arg_1.skillLevel;
            var _local_3:int = _arg_2.skillLevel;
            if (_local_4 < _local_3)
            {
                return (1);
            };
            if (_local_4 == _local_3)
            {
                return (0);
            };
            return (-1);
        }


        public function get userId():int
        {
            return (_userId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get teamId():int
        {
            return (_teamId);
        }

        public function get skillLevel():int
        {
            return (_skillLevel);
        }

        public function get totalScore():int
        {
            return (_totalScore);
        }

        public function get scoreToNextLevel():int
        {
            return (_scoreToNextLevel);
        }


    }
}

