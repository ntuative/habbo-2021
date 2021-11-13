package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.exporters.core.IShapeExporter;
    import com.codeazur.utils.StringUtils;

    public class SWFShapeWithStyle extends SWFShape 
    {

        protected var _SafeStr_712:Vector.<SWFFillStyle> = new Vector.<SWFFillStyle>();
        protected var _SafeStr_713:Vector.<SWFLineStyle> = new Vector.<SWFLineStyle>();

        public function SWFShapeWithStyle(_arg_1:SWFData=null, _arg_2:uint=1, _arg_3:Number=20)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get initialFillStyles():Vector.<SWFFillStyle>
        {
            return (_SafeStr_712);
        }

        public function get initialLineStyles():Vector.<SWFLineStyle>
        {
            return (_SafeStr_713);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            var _local_6:uint;
            _arg_1.resetBitsPending();
            var _local_3:uint = readStyleArrayLength(_arg_1, _arg_2);
            _local_6 = 0;
            while (_local_6 < _local_3)
            {
                initialFillStyles.push(_arg_1.readFILLSTYLE(_arg_2));
                _local_6++;
            };
            var _local_4:uint = readStyleArrayLength(_arg_1, _arg_2);
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                initialLineStyles.push(((_arg_2 <= 3) ? _arg_1.readLINESTYLE(_arg_2) : _arg_1.readLINESTYLE2(_arg_2)));
                _local_6++;
            };
            _arg_1.resetBitsPending();
            var _local_7:uint = _arg_1.readUB(4);
            var _local_5:uint = _arg_1.readUB(4);
            readShapeRecords(_arg_1, _local_7, _local_5, _arg_2);
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            var _local_5:uint;
            _arg_1.resetBitsPending();
            var _local_3:uint = initialFillStyles.length;
            writeStyleArrayLength(_arg_1, _local_3, _arg_2);
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                initialFillStyles[_local_5].publish(_arg_1, _arg_2);
                _local_5++;
            };
            var _local_4:uint = initialLineStyles.length;
            writeStyleArrayLength(_arg_1, _local_4, _arg_2);
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                initialLineStyles[_local_5].publish(_arg_1, _arg_2);
                _local_5++;
            };
            var _local_6:uint = _arg_1.calculateMaxBits(false, [getMaxFillStyleIndex()]);
            var _local_7:uint = _arg_1.calculateMaxBits(false, [getMaxLineStyleIndex()]);
            _arg_1.resetBitsPending();
            _arg_1.writeUB(4, _local_6);
            _arg_1.writeUB(4, _local_7);
            writeShapeRecords(_arg_1, _local_6, _local_7, _arg_2);
        }

        override public function export(_arg_1:IShapeExporter=null):void
        {
            _SafeStr_704 = _SafeStr_712.concat();
            _SafeStr_705 = _SafeStr_713.concat();
            super.export(_arg_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = "";
            if (_SafeStr_712.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat(_arg_1)) + "FillStyles:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_712.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + (_local_3 + 1)) + "] ") + _SafeStr_712[_local_3].toString()));
                    _local_3++;
                };
            };
            if (_SafeStr_713.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat(_arg_1)) + "LineStyles:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_713.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + (_local_3 + 1)) + "] ") + _SafeStr_713[_local_3].toString()));
                    _local_3++;
                };
            };
            return (_local_2 + super.toString(_arg_1));
        }

        protected function readStyleArrayLength(_arg_1:SWFData, _arg_2:uint=1):uint
        {
            var _local_3:uint = _arg_1.readUI8();
            if (((_arg_2 >= 2) && (_local_3 == 0xFF)))
            {
                _local_3 = _arg_1.readUI16();
            };
            return (_local_3);
        }

        protected function writeStyleArrayLength(_arg_1:SWFData, _arg_2:uint, _arg_3:uint=1):void
        {
            if (((_arg_3 >= 2) && (_arg_2 > 254)))
            {
                _arg_1.writeUI8(0xFF);
                _arg_1.writeUI16(_arg_2);
            }
            else
            {
                _arg_1.writeUI8(_arg_2);
            };
        }


    }
}

