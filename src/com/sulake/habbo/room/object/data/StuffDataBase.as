package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.adobe.serialization.json.JSONDecoder;

    public class StuffDataBase implements IStuffData
    {

        private var _SafeStr_852:int;
        private var _uniqueSerialNumber:int = 0;
        private var _uniqueSeriesSize:int = 0;


        public function set flags(_arg_1:int):void
        {
            _SafeStr_852 = _arg_1;
        }

        public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            if ((_SafeStr_852 & 0x0100) > 0)
            {
                _uniqueSerialNumber = _arg_1.readInteger();
                _uniqueSeriesSize = _arg_1.readInteger();
            };
        }

        public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            _uniqueSerialNumber = _arg_1.getNumber("furniture_unique_serial_number");
            _uniqueSeriesSize = _arg_1.getNumber("furniture_unique_edition_size");
        }

        public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            _arg_1.setNumber("furniture_unique_serial_number", _uniqueSerialNumber);
            _arg_1.setNumber("furniture_unique_edition_size", _uniqueSeriesSize);
        }

        public function get uniqueSerialNumber():int
        {
            return (_uniqueSerialNumber);
        }

        public function get uniqueSeriesSize():int
        {
            return (_uniqueSeriesSize);
        }

        public function set uniqueSerialNumber(_arg_1:int):void
        {
            _uniqueSerialNumber = _arg_1;
        }

        public function set uniqueSeriesSize(_arg_1:int):void
        {
            _uniqueSeriesSize = _arg_1;
        }

        public function getLegacyString():String
        {
            return ("");
        }

        public function compare(_arg_1:IStuffData):Boolean
        {
            return (false);
        }

        public function get rarityLevel():int
        {
            return (-1);
        }

        public function get state():int
        {
            var _local_1:Number = Number(getLegacyString());
            return ((isNaN(_local_1)) ? -1 : _local_1);
        }

        public function getJSONValue(_arg_1:String):String
        {
            var _local_2:String;
            try
            {
                _local_2 = new JSONDecoder(getLegacyString(), true).getValue()[_arg_1];
                return _local_2;
            }
            catch(error:Error)
            {
                return ("");
            };

            return "";
        }


    }
}