package com.sulake.habbo.communication.messages.parser.talent
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.utils._SafeStr_25;

        public class TalentTrack 
    {

        public static const STATE_LOCKED:int = 0;
        public static const _SafeStr_2102:int = 1;
        public static const _SafeStr_2103:int = 2;

        private var _name:String;
        private var _SafeStr_2104:int;
        private var _levels:Vector.<TalentTrackLevel>;


        public function parse(_arg_1:IMessageDataWrapper):void
        {
            var _local_4:int;
            var _local_3:TalentTrackLevel;
            _name = _arg_1.readString();
            _levels = new Vector.<TalentTrackLevel>();
            var _local_2:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_3 = new TalentTrackLevel();
                _local_3.parse(_arg_1);
                if (_local_3.state == 1)
                {
                    _SafeStr_2104 = _local_4;
                };
                _levels.push(_local_3);
                _local_4++;
            };
        }

        public function findTaskByAchievementId(_arg_1:int):TalentTrackTask
        {
            var _local_3:TalentTrackTask;
            var _local_4:TalentTrackTask;
            for each (var _local_2:TalentTrackLevel in _levels)
            {
                if (_local_2.state != 0)
                {
                    _local_3 = _local_2.findTaskByAchievementId(_arg_1);
                    if (_local_3 != null)
                    {
                        _local_4 = _local_3;
                    };
                };
            };
            return (_local_4);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get levels():Vector.<TalentTrackLevel>
        {
            return (_levels);
        }

        public function get progressPerLevel():Number
        {
            if (_levels.length > 0)
            {
                return (1 / _levels.length);
            };
            return (0);
        }

        public function get totalProgress():Number
        {
            var _local_1:Number;
            if (_levels.length > 0)
            {
                _local_1 = _levels[_SafeStr_2104].levelProgress;
                return (_SafeStr_25.clamp(((_SafeStr_2104 * progressPerLevel) + (_local_1 * progressPerLevel))));
            };
            return (0);
        }

        public function get progressForCurrentLevel():Number
        {
            if (_levels.length > 0)
            {
                return (_SafeStr_2104 * progressPerLevel);
            };
            return (0);
        }

        public function removeFirstLevel():void
        {
            _levels.shift();
            _SafeStr_2104 = Math.max(0, (_SafeStr_2104 - 1));
        }


    }
}

