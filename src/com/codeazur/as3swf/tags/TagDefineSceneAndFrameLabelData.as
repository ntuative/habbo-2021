package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFScene;
    import com.codeazur.as3swf.data.SWFFrameLabel;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagDefineSceneAndFrameLabelData implements ITag 
    {

        public static const TYPE:uint = 86;

        protected var _SafeStr_734:Vector.<SWFScene>;
        protected var _frameLabels:Vector.<SWFFrameLabel>;

        public function TagDefineSceneAndFrameLabelData()
        {
            _SafeStr_734 = new Vector.<SWFScene>();
            _frameLabels = new Vector.<SWFFrameLabel>();
        }

        public function get scenes():Vector.<SWFScene>
        {
            return (_SafeStr_734);
        }

        public function get frameLabels():Vector.<SWFFrameLabel>
        {
            return (_frameLabels);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_8:uint;
            var _local_9:uint;
            var _local_7:String;
            var _local_5:uint;
            var _local_10:String;
            var _local_6:uint = _arg_1.readEncodedU32();
            _local_8 = 0;
            while (_local_8 < _local_6)
            {
                _local_9 = _arg_1.readEncodedU32();
                _local_7 = _arg_1.readString();
                _SafeStr_734.push(new SWFScene(_local_9, _local_7));
                _local_8++;
            };
            var _local_11:uint = _arg_1.readEncodedU32();
            _local_8 = 0;
            while (_local_8 < _local_11)
            {
                _local_5 = _arg_1.readEncodedU32();
                _local_10 = _arg_1.readString();
                _frameLabels.push(new SWFFrameLabel(_local_5, _local_10));
                _local_8++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_6:SWFScene;
            var _local_4:SWFFrameLabel;
            var _local_5:SWFData = new SWFData();
            _local_5.writeEncodedU32(this.scenes.length);
            _local_3 = 0;
            while (_local_3 < this.scenes.length)
            {
                _local_6 = this.scenes[_local_3];
                _local_5.writeEncodedU32(_local_6.offset);
                _local_5.writeString(_local_6.name);
                _local_3++;
            };
            _local_5.writeEncodedU32(this.frameLabels.length);
            _local_3 = 0;
            while (_local_3 < this.frameLabels.length)
            {
                _local_4 = this.frameLabels[_local_3];
                _local_5.writeEncodedU32(_local_4.frameNumber);
                _local_5.writeString(_local_4.name);
                _local_3++;
            };
            _arg_1.writeTagHeader(type, _local_5.length);
            _arg_1.writeBytes(_local_5);
        }

        public function get type():uint
        {
            return (86);
        }

        public function get name():String
        {
            return ("DefineSceneAndFrameLabelData");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
            if (_SafeStr_734.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Scenes:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_734.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_734[_local_3].toString()));
                    _local_3++;
                };
            };
            if (_frameLabels.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "FrameLabels:"));
                _local_3 = 0;
                while (_local_3 < _frameLabels.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _frameLabels[_local_3].toString()));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}

