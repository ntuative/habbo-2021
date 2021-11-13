package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.IRoomObjectModel;

    public class VoteResultStuffData extends StuffDataBase implements IStuffData 
    {

        public static const FORMAT_KEY:int = 3;
        private static const INTERNAL_STATE_KEY:String = "s";
        private static const INTERNAL_RESULT_KEY:String = "r";

        private var _SafeStr_448:String = "";
        private var _result:int;


        override public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            _SafeStr_448 = _arg_1.readString();
            _result = _arg_1.readInteger();
            super.initializeFromIncomingMessage(_arg_1);
        }

        override public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            super.writeRoomObjectModel(_arg_1);
            _arg_1.setNumber("furniture_data_format", 3);
            var _local_2:Map = new Map();
            _local_2.add("s", _SafeStr_448);
            _local_2.add("r", _result.toString());
            _arg_1.setStringToStringMap("furniture_data", _local_2);
        }

        override public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            super.initializeFromRoomObjectModel(_arg_1);
            var _local_2:Map = _arg_1.getStringToStringMap("furniture_data");
            _SafeStr_448 = _local_2.getValue("s");
            _result = _local_2.getValue("r");
        }

        override public function getLegacyString():String
        {
            return (_SafeStr_448);
        }

        public function setString(_arg_1:String):void
        {
            _SafeStr_448 = _arg_1;
        }

        public function get result():int
        {
            return (_result);
        }

        override public function compare(_arg_1:IStuffData):Boolean
        {
            return (true);
        }


    }
}

