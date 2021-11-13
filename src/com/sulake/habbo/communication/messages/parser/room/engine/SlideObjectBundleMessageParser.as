package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SlideObjectBundleMessageParser implements IMessageParser
    {

        private var _id:int;
        private var _objectList:Array;
        private var _avatar:SlideObjectMessageData = null;


        public function get id():int
        {
            return (_id);
        }

        public function get avatar():SlideObjectMessageData
        {
            return (_avatar);
        }

        public function get objectList():Array
        {
            return (_objectList);
        }

        public function flush():Boolean
        {
            _id = -1;
            _avatar = null;
            _objectList = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_14:int;
            var _local_7:SlideObjectMessageData;
            var _local_2:Vector3d;
            var _local_9:Vector3d;
            var _local_12:Number;
            var _local_3:Number;
            var _local_6:int;
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_10:Number = _arg_1.readInteger();
            var _local_11:Number = _arg_1.readInteger();
            var _local_5:Number = _arg_1.readInteger();
            var _local_4:Number = _arg_1.readInteger();
            var _local_8:int = _arg_1.readInteger();
            _objectList = [];
            _local_6 = 0;
            while (_local_6 < _local_8)
            {
                _local_14 = _arg_1.readInteger();
                _local_12 = Number(_arg_1.readString());
                _local_3 = Number(_arg_1.readString());
                _local_2 = new Vector3d(_local_10, _local_11, _local_12);
                _local_9 = new Vector3d(_local_5, _local_4, _local_3);
                _local_7 = new SlideObjectMessageData(_local_14, _local_2, _local_9);
                _objectList.push(_local_7);
                _local_6++;
            };
            _id = _arg_1.readInteger();
            if (!_arg_1.bytesAvailable)
            {
                return (true);
            };
            var _local_13:int = _arg_1.readInteger();
            switch (_local_13)
            {
                case 0:
                    break;
                case 1:
                    _local_14 = _arg_1.readInteger();
                    _local_12 = Number(_arg_1.readString());
                    _local_3 = Number(_arg_1.readString());
                    _local_2 = new Vector3d(_local_10, _local_11, _local_12);
                    _local_9 = new Vector3d(_local_5, _local_4, _local_3);
                    _avatar = new SlideObjectMessageData(_local_14, _local_2, _local_9, "mv");
                    break;
                case 2:
                    _local_14 = _arg_1.readInteger();
                    _local_12 = Number(_arg_1.readString());
                    _local_3 = Number(_arg_1.readString());
                    _local_2 = new Vector3d(_local_10, _local_11, _local_12);
                    _local_9 = new Vector3d(_local_5, _local_4, _local_3);
                    _avatar = new SlideObjectMessageData(_local_14, _local_2, _local_9, "sld");
                    break;
                default:
                    Logger.log("** Incompatible character movetype!");
            };
            return (true);
        }


    }
}