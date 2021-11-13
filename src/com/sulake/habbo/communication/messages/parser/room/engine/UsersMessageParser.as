package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UsersMessageParser implements IMessageParser
    {

        private var _users:Array = [];


        public static function convertOldPetFigure(_arg_1:String):String
        {
            var _local_5:int;
            var _local_6:int;
            var _local_10:Array = new Array("FF7B3A", "FF9763", "FFCDB3", "F59500", "FBBD5C", "FEE4B2", "EDD400", "F5E759", "FBF8B1", "84A95F", "B0C993", "DBEFC7", "65B197", "91C7B5", "C5EDDE", "7F89B2", "98A1C5", "CAD2EC", "A47FB8", "C09ED5", "DBC7E9", "BD7E9D", "DA9DBD", "ECC6DB", "DD7B7D", "F08B90", "F9BABF", "ABABAB", "D4D4D4", "FFFFFF", "D98961", "DFA281", "F1D2C2", "D5B35F", "DAC480", "FCFAD3", "EAA7AF", "86BC40", "E8CE25", "8E8839", "888F67", "5E9414", "84CE84", "96E75A", "88E70D", "B99105", "C8D71D", "838851", "C08337", "83A785", "E6AF26", "ECFF99", "94FFF9", "ABC8E5", "F2E5CC", "D2FF00");
            var _local_4:Array = _arg_1.split(" ");
            if (_local_4.length < 3)
            {
                return ("");
            };
            var _local_8:int = _local_4[0];
            var _local_2:int = (_local_4[1] + 1);
            var _local_9:String = String(_local_4[2]);
            _local_9 = String(_local_4[2]).substr((_local_9.length - 6), 6);
            var _local_3:int = 25;
            if (_local_8 <= 1)
            {
                _local_5 = ((_local_3 * _local_8) + _local_2);
            }
            else
            {
                _local_5 = 64;
            };
            _local_6 = (_local_10.indexOf(_local_9.toUpperCase()) + 1);
            var _local_7:String = "";
            _local_7 = (_local_7 + ((("phd-" + _local_5) + "-") + _local_6));
            _local_7 = (_local_7 + (((".pbd-" + _local_5) + "-") + _local_6));
            _local_7 = (_local_7 + (((".ptl-" + _local_5) + "-") + _local_6));
            return (_local_7);
        }


        public function flush():Boolean
        {
            _users = [];
            return (true);
        }

        public function getUserCount():int
        {
            return (_users.length);
        }

        public function getUser(_arg_1:int):UserMessageData
        {
            if (((_arg_1 < 0) || (_arg_1 >= getUserCount())))
            {
                return (null);
            };
            var _local_2:UserMessageData = (_users[_arg_1] as UserMessageData);
            if (_local_2 != null)
            {
                _local_2.setReadOnly();
            };
            return (_local_2);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_7:int;
            var _local_17:int;
            var _local_8:String;
            var _local_10:String;
            var _local_13:String;
            var _local_18:int;
            var _local_6:int;
            var _local_2:int;
            var _local_3:String;
            var _local_11:int;
            var _local_14:int;
            var _local_16:UserMessageData;
            var _local_15:String;
            var _local_4:int;
            var _local_12:Array;
            var _local_9:int;
            _users = [];
            var _local_5:int = _arg_1.readInteger();
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                _local_17 = _arg_1.readInteger();
                _local_8 = _arg_1.readString();
                _local_10 = _arg_1.readString();
                _local_13 = _arg_1.readString();
                _local_18 = _arg_1.readInteger();
                _local_6 = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _local_11 = _arg_1.readInteger();
                _local_14 = _arg_1.readInteger();
                _local_16 = new UserMessageData(_local_18);
                _local_16.dir = _local_11;
                _local_16.name = _local_8;
                _local_16.custom = _local_10;
                _local_16.x = _local_6;
                _local_16.y = _local_2;
                _local_16.z = Number(_local_3);
                _users.push(_local_16);
                if (_local_14 == 1)
                {
                    _local_16.webID = _local_17;
                    _local_16.userType = 1;
                    _local_16.sex = resolveSex(_arg_1.readString());
                    _local_16.groupID = ("" + _arg_1.readInteger());
                    _local_16.groupStatus = _arg_1.readInteger();
                    _local_16.groupName = _arg_1.readString();
                    _local_15 = _arg_1.readString();
                    if (_local_15 != "")
                    {
                        _local_13 = convertSwimFigure(_local_15, _local_13, _local_16.sex);
                    };
                    _local_16.figure = _local_13;
                    _local_16.achievementScore = _arg_1.readInteger();
                    _local_16.isModerator = _arg_1.readBoolean();
                }
                else
                {
                    if (_local_14 == 2)
                    {
                        _local_16.userType = 2;
                        _local_16.figure = _local_13;
                        _local_16.webID = _local_17;
                        _local_16.subType = _arg_1.readInteger().toString();
                        _local_16.ownerId = _arg_1.readInteger();
                        _local_16.ownerName = _arg_1.readString();
                        _local_16.rarityLevel = _arg_1.readInteger();
                        _local_16.hasSaddle = _arg_1.readBoolean();
                        _local_16.isRiding = _arg_1.readBoolean();
                        _local_16.canBreed = _arg_1.readBoolean();
                        _local_16.canHarvest = _arg_1.readBoolean();
                        _local_16.canRevive = _arg_1.readBoolean();
                        _local_16.hasBreedingPermission = _arg_1.readBoolean();
                        _local_16.petLevel = _arg_1.readInteger();
                        _local_16.petPosture = _arg_1.readString();
                    }
                    else
                    {
                        if (_local_14 == 3)
                        {
                            _local_16.userType = 3;
                            _local_16.webID = (_local_18 * -1);
                            if (_local_13.indexOf("/") == -1)
                            {
                                _local_16.figure = _local_13;
                            }
                            else
                            {
                                _local_16.figure = "hr-100-.hd-180-1.ch-876-66.lg-270-94.sh-300-64";
                            };
                            _local_16.sex = "M";
                        }
                        else
                        {
                            if (_local_14 == 4)
                            {
                                _local_16.userType = 4;
                                _local_16.webID = _local_17;
                                _local_16.sex = resolveSex(_arg_1.readString());
                                _local_16.figure = _local_13;
                                _local_16.ownerId = _arg_1.readInteger();
                                _local_16.ownerName = _arg_1.readString();
                                _local_4 = _arg_1.readInteger();
                                if (_local_4 > 0)
                                {
                                    _local_12 = [];
                                    _local_9 = 0;
                                    while (_local_9 < _local_4)
                                    {
                                        _local_12.push(_arg_1.readShort());
                                        _local_9++;
                                    };
                                    _local_16.botSkills = _local_12;
                                };
                            };
                        };
                    };
                };
                _local_7++;
            };
            return (true);
        }

        private function resolveSex(_arg_1:String):String
        {
            if (_arg_1.substr(0, 1).toLowerCase() == "f")
            {
                return ("F");
            };
            return ("M");
        }

        private function convertSwimFigure(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_9:int;
            var _local_13:String;
            var _local_17:Array;
            var _local_12:String;
            var _local_6:Array;
            var _local_14:String;
            var _local_7:String;
            var _local_10:int;
            var _local_4:Array = _arg_2.split(".");
            var _local_15:int = 1;
            var _local_11:int = 1;
            var _local_8:int = 1;
            var _local_5:int = 10000;
            _local_9 = 0;
            while (_local_9 < _local_4.length)
            {
                _local_13 = _local_4[_local_9];
                _local_17 = _local_13.split("-");
                if (_local_17.length > 2)
                {
                    _local_12 = _local_17[0];
                    if (_local_12 == "hd")
                    {
                        _local_15 = _local_17[2];
                    };
                };
                _local_9++;
            };
            var _local_18:Array = ["238,238,238", "250,56,49", "253,146,160", "42,199,210", "53,51,44", "239,255,146", "198,255,152", "255,146,90", "157,89,126", "182,243,255", "109,255,51", "51,120,201", "255,182,49", "223,161,233", "249,251,50", "202,175,143", "197,198,197", "71,98,61", "138,131,97", "255,140,51", "84,198,39", "30,108,153", "152,79,136", "119,200,255", "255,192,142", "60,75,135", "124,44,71", "215,255,227", "143,63,28", "255,99,147", "31,155,121", "253,255,51"];
            var _local_19:Array = _arg_1.split("=");
            if (_local_19.length > 1)
            {
                _local_6 = (_local_19[1] as String).split("/");
                _local_14 = _local_6[0];
                _local_7 = _local_6[1];
                if (_arg_3 == "F")
                {
                    _local_8 = 10010;
                }
                else
                {
                    _local_8 = 10011;
                };
                _local_10 = _local_18.indexOf(_local_7);
                _local_11 = ((_local_5 + _local_10) + 1);
            };
            var _local_16:String = (((((".bds-10001-" + _local_15) + ".ss-") + _local_8) + "-") + _local_11);
            return (_arg_2 + _local_16);
        }


    }
}
