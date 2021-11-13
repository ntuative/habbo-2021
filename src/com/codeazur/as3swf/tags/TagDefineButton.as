package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFButtonRecord;
    import com.codeazur.as3swf.data.actions.IAction;
    import flash.utils.Dictionary;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagDefineButton implements IDefinitionTag 
    {

        public static const TYPE:uint = 7;
        public static const STATE_UP:String = "up";
        public static const STATE_OVER:String = "over";
        public static const STATE_DOWN:String = "down";
        public static const STATE_HIT:String = "hit";

        protected var _SafeStr_720:uint;
        protected var _characters:Vector.<SWFButtonRecord>;
        protected var _SafeStr_701:Vector.<IAction>;
        protected var frames:Dictionary;

        public function TagDefineButton()
        {
            _characters = new Vector.<SWFButtonRecord>();
            _SafeStr_701 = new Vector.<IAction>();
            frames = new Dictionary();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get characters():Vector.<SWFButtonRecord>
        {
            return (_characters);
        }

        public function get actions():Vector.<IAction>
        {
            return (_SafeStr_701);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:SWFButtonRecord;
            var _local_6:IAction;
            _SafeStr_720 = _arg_1.readUI16();
            while ((_local_5 = _arg_1.readBUTTONRECORD()) != null)
            {
                _characters.push(_local_5);
            };
            while ((_local_6 = _arg_1.readACTIONRECORD()) != null)
            {
                _SafeStr_701.push(_local_6);
            };
            processRecords();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_4:SWFData = new SWFData();
            _local_4.writeUI16(characterId);
            _local_3 = 0;
            while (_local_3 < characters.length)
            {
                _arg_1.writeBUTTONRECORD(characters[_local_3]);
                _local_3++;
            };
            _arg_1.writeUI8(0);
            _local_3 = 0;
            while (_local_3 < actions.length)
            {
                _arg_1.writeACTIONRECORD(actions[_local_3]);
                _local_3++;
            };
            _arg_1.writeUI8(0);
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:uint;
            var _local_2:TagDefineButton = new TagDefineButton();
            _local_2.characterId = characterId;
            _local_1 = 0;
            while (_local_1 < characters.length)
            {
                _local_2.characters.push(characters[_local_1].clone());
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < actions.length)
            {
                _local_2.actions.push(actions[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        public function getRecordsByState(_arg_1:String):Vector.<SWFButtonRecord>
        {
            return (frames[_arg_1] as Vector.<SWFButtonRecord>);
        }

        public function get type():uint
        {
            return (7);
        }

        public function get name():String
        {
            return ("DefineButton");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        protected function processRecords():void
        {
            var _local_4:uint;
            var _local_2:SWFButtonRecord;
            var _local_3:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
            var _local_1:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
            var _local_6:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
            var _local_5:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
            _local_4 = 0;
            while (_local_4 < characters.length)
            {
                _local_2 = characters[_local_4];
                if (_local_2._SafeStr_332)
                {
                    _local_3.push(_local_2);
                };
                if (_local_2._SafeStr_331)
                {
                    _local_1.push(_local_2);
                };
                if (_local_2._SafeStr_330)
                {
                    _local_6.push(_local_2);
                };
                if (_local_2._SafeStr_329)
                {
                    _local_5.push(_local_2);
                };
                _local_4++;
            };
            frames["up"] = _local_3.sort(sortByDepthCompareFunction);
            frames["over"] = _local_1.sort(sortByDepthCompareFunction);
            frames["down"] = _local_6.sort(sortByDepthCompareFunction);
            frames["hit"] = _local_5.sort(sortByDepthCompareFunction);
        }

        protected function sortByDepthCompareFunction(_arg_1:SWFButtonRecord, _arg_2:SWFButtonRecord):Number
        {
            if (_arg_1.placeDepth < _arg_2.placeDepth)
            {
                return (-1);
            };
            if (_arg_1.placeDepth > _arg_2.placeDepth)
            {
                return (1);
            };
            return (0);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + _SafeStr_720);
            if (_characters.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Characters:"));
                _local_3 = 0;
                while (_local_3 < _characters.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _characters[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (_SafeStr_701.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Actions:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_701.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_701[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}

