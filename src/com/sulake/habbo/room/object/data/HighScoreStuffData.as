package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObjectModelController;

    public class HighScoreStuffData extends StuffDataBase implements IStuffData 
    {

        public static const FORMAT_KEY:int = 6;

        private var _SafeStr_448:String = "";
        private var _scoreType:int = -1;
        private var _clearType:int = -1;
        private var _entries:Vector.<HighScoreData>;


        public function get scoreType():int
        {
            return (_scoreType);
        }

        public function get clearType():int
        {
            return (_clearType);
        }

        public function get entries():Vector.<HighScoreData>
        {
            return (_entries);
        }

        override public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            var _local_5:int;
            var _local_2:HighScoreData;
            var _local_4:int;
            var _local_6:int;
            _entries = new Vector.<HighScoreData>();
            _SafeStr_448 = _arg_1.readString();
            _scoreType = _arg_1.readInteger();
            _clearType = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_2 = new HighScoreData();
                _local_2.score = _arg_1.readInteger();
                _local_4 = _arg_1.readInteger();
                _local_6 = 0;
                while (_local_6 < _local_4)
                {
                    _local_2.addUser(_arg_1.readString());
                    _local_6++;
                };
                _entries.push(_local_2);
                _local_5++;
            };
        }

        override public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            var _local_4:int;
            var _local_2:HighScoreData;
            _entries = new Vector.<HighScoreData>();
            super.initializeFromRoomObjectModel(_arg_1);
            _scoreType = _arg_1.getNumber("furniture_highscore_score_type");
            _clearType = _arg_1.getNumber("furniture_highscore_clear_type");
            var _local_3:int = _arg_1.getNumber("furniture_highscore_data_entry_count");
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = new HighScoreData();
                _local_2.score = _arg_1.getNumber(("furniture_highscore_data_entry_base_score_" + _local_4));
                _local_2.users = _arg_1.getStringArray(("furniture_highscore_data_entry_base_users_" + _local_4));
                _entries.push(_local_2);
                _local_4++;
            };
        }

        override public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            var _local_3:int;
            var _local_2:HighScoreData;
            super.writeRoomObjectModel(_arg_1);
            _arg_1.setNumber("furniture_data_format", 6);
            _arg_1.setNumber("furniture_highscore_score_type", _scoreType);
            _arg_1.setNumber("furniture_highscore_clear_type", _clearType);
            if (_entries)
            {
                _arg_1.setNumber("furniture_highscore_data_entry_count", _entries.length);
                _local_3 = 0;
                while (_local_3 < _entries.length)
                {
                    _local_2 = _entries[_local_3];
                    _arg_1.setNumber(("furniture_highscore_data_entry_base_score_" + _local_3), _local_2.score);
                    _arg_1.setStringArray(("furniture_highscore_data_entry_base_users_" + _local_3), _local_2.users);
                    _local_3++;
                };
            };
        }

        override public function getLegacyString():String
        {
            return (_SafeStr_448);
        }


    }
}

