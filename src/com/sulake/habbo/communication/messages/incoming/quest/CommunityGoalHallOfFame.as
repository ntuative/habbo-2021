package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityGoalHallOfFame implements IDisposable 
    {

        private var _goalCode:String;
        private var _hof:Array = [];

        public function CommunityGoalHallOfFame(_arg_1:IMessageDataWrapper):void
        {
            var _local_3:int;
            super();
            _goalCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _hof.push(new HallOfFameEntryData(_arg_1));
                _local_3++;
            };
        }

        public function dispose():void
        {
            _hof = null;
        }

        public function get disposed():Boolean
        {
            return (_hof == null);
        }

        public function get hof():Array
        {
            return (_hof);
        }

        public function get goalCode():String
        {
            return (_goalCode);
        }


    }
}