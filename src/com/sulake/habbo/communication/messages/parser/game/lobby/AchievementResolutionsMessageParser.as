package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementResolutionData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementResolutionsMessageParser implements IMessageParser 
    {

        private var _stuffId:int;
        private var _achievements:Vector.<AchievementResolutionData>;
        private var _endTime:int;


        public function flush():Boolean
        {
            _stuffId = -1;
            for each (var _local_1:AchievementResolutionData in _achievements)
            {
                _local_1.dispose();
            };
            _achievements = new Vector.<AchievementResolutionData>(0);
            _endTime = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _stuffId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _achievements.push(new AchievementResolutionData(_arg_1));
                _local_2++;
            };
            _endTime = _arg_1.readInteger();
            return (true);
        }

        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get achievements():Vector.<AchievementResolutionData>
        {
            return (_achievements);
        }

        public function get endTime():int
        {
            return (_endTime);
        }


    }
}