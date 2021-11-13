package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class _SafeStr_84
    {


        public static function parseItemData(_arg_1:IMessageDataWrapper):ItemMessageData
        {
            var _local_17:String;
            var _local_23:String;
            var _local_13:int;
            var _local_14:int;
            var _local_21:int;
            var _local_15:int;
            var _local_19:String;
            var _local_10:Array;
            var _local_16:Number;
            var _local_18:Number;
            var _local_8:Number;
            var _local_11:int = int(_arg_1.readString());
            var _local_7:int = _arg_1.readInteger();
            var _local_2:String = _arg_1.readString();
            var _local_5:String = _arg_1.readString();
            var _local_3:int = _arg_1.readInteger();
            var _local_4:int = _arg_1.readInteger();
            var _local_9:int = _arg_1.readInteger();
            var _local_20:int;
            var _local_12:Number = parseFloat(_local_5);
            if (!isNaN(_local_12))
            {
                _local_20 = int(_local_5);
            };
            Logger.log("\n\n PARSING WALL ITEM: ");
            Logger.log(("wallItemId: " + _local_11));
            Logger.log(("wallItemTypeId: " + _local_7));
            Logger.log(("location: " + _local_2));
            Logger.log(("dataStr: " + _local_5));
            Logger.log(("secondsToExpiration: " + _local_3));
            Logger.log(("state: " + _local_20));
            var _local_6:ItemMessageData;
            var _local_22:Array;
            var _local_24:String;
            if (_local_2.indexOf(":") == 0)
            {
                _local_6 = new ItemMessageData(_local_11, _local_7, false);
                _local_22 = _local_2.split(" ");
                if (_local_22.length >= 3)
                {
                    _local_17 = String(_local_22[0]);
                    _local_23 = String(_local_22[1]);
                    _local_24 = String(_local_22[2]);
                    if (((_local_17.length > 3) && (_local_23.length > 2)))
                    {
                        _local_17 = _local_17.substr(3);
                        _local_23 = _local_23.substr(2);
                        _local_22 = _local_17.split(",");
                        if (_local_22.length >= 2)
                        {
                            _local_13 = _local_22[0];
                            _local_14 = _local_22[1];
                            _local_22 = _local_23.split(",");
                            if (_local_22.length >= 2)
                            {
                                _local_21 = _local_22[0];
                                _local_15 = _local_22[1];
                                _local_6.wallX = _local_13;
                                _local_6.wallY = _local_14;
                                _local_6.localX = _local_21;
                                _local_6.localY = _local_15;
                                _local_6.dir = _local_24;
                                _local_6.data = _local_5;
                                _local_6.state = _local_20;
                            };
                        };
                    };
                };
            }
            else
            {
                _local_6 = new ItemMessageData(_local_11, _local_7, true);
                _local_22 = _local_2.split(" ");
                if (_local_22.length >= 2)
                {
                    _local_24 = String(_local_22[0]);
                    if (((_local_24 == "rightwall") || (_local_24 == "frontwall")))
                    {
                        _local_24 = "r";
                    }
                    else
                    {
                        _local_24 = "l";
                    };
                    _local_19 = String(_local_22[1]);
                    _local_10 = _local_19.split(",");
                    if (_local_10.length >= 3)
                    {
                        _local_16 = 0;
                        _local_18 = parseFloat(_local_10[0]);
                        _local_8 = parseFloat(_local_10[1]);
                        _local_6.y = _local_18;
                        _local_6.z = _local_8;
                        _local_6.dir = _local_24;
                        _local_6.data = _local_5;
                        _local_6.state = _local_20;
                    };
                };
            };
            _local_6.usagePolicy = _local_4;
            _local_6.ownerId = _local_9;
            _local_6.secondsToExpiration = _local_3;
            return (_local_6);
        }


    }
}