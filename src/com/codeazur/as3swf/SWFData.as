package com.codeazur.as3swf
{
    import com.codeazur.utils.BitArray;
    import flash.utils.ByteArray;
    import com.codeazur.utils._SafeStr_76;
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.data.SWFMatrix;
    import com.codeazur.as3swf.data.SWFColorTransform;
    import com.codeazur.as3swf.data.SWFColorTransformWithAlpha;
    import com.codeazur.as3swf.data.SWFShape;
    import com.codeazur.as3swf.data.SWFShapeWithStyle;
    import com.codeazur.as3swf.data.SWFShapeRecordStraightEdge;
    import com.codeazur.as3swf.data.SWFShapeRecordCurvedEdge;
    import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;
    import com.codeazur.as3swf.data.SWFFillStyle;
    import com.codeazur.as3swf.data.SWFLineStyle;
    import com.codeazur.as3swf.data.SWFLineStyle2;
    import com.codeazur.as3swf.data.SWFButtonRecord;
    import com.codeazur.as3swf.data.SWFButtonCondAction;
    import com.codeazur.as3swf.factories._SafeStr_83;
    import com.codeazur.as3swf.data.filters.IFilter;
    import com.codeazur.as3swf.data.SWFTextRecord;
    import com.codeazur.as3swf.data.SWFGlyphEntry;
    import com.codeazur.as3swf.data.SWFZoneRecord;
    import com.codeazur.as3swf.data.SWFZoneData;
    import com.codeazur.as3swf.data.SWFKerningRecord;
    import com.codeazur.as3swf.data.SWFGradient;
    import com.codeazur.as3swf.data.SWFFocalGradient;
    import com.codeazur.as3swf.data.SWFGradientRecord;
    import com.codeazur.as3swf.data.SWFMorphFillStyle;
    import com.codeazur.as3swf.data.SWFMorphLineStyle;
    import com.codeazur.as3swf.data.SWFMorphLineStyle2;
    import com.codeazur.as3swf.data.SWFMorphGradient;
    import com.codeazur.as3swf.data.SWFMorphFocalGradient;
    import com.codeazur.as3swf.data.SWFMorphGradientRecord;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.factories._SafeStr_85;
    import com.codeazur.as3swf.data.SWFActionValue;
    import com.codeazur.as3swf.data.SWFRegisterParam;
    import com.codeazur.as3swf.data.SWFSymbol;
    import com.codeazur.as3swf.data.SWFSoundInfo;
    import com.codeazur.as3swf.data.SWFSoundEnvelope;
    import com.codeazur.as3swf.data.SWFClipActions;
    import com.codeazur.as3swf.data.SWFClipActionRecord;
    import com.codeazur.as3swf.data.SWFClipEventFlags;
    import com.codeazur.as3swf.data.SWFRecordHeader;
    import com.codeazur.as3swf.data.SWFRawTag;
    import com.codeazur.as3swf.data.*;
    import com.codeazur.as3swf.data.filters.*;
    import com.codeazur.as3swf.factories.*;

    public class SWFData extends BitArray
    {

        public static const FLOAT16_EXPONENT_BASE:Number = 15;

        public function SWFData()
        {
            endian = "littleEndian";
        }

        public static function dump(_arg_1:ByteArray, _arg_2:uint, _arg_3:int=0):void
        {
            var _local_7:uint;
            var _local_5:String;
            var _local_9:String;
            var _local_8:uint = _arg_1.position;
            var _local_10:Number = Math.min(Math.max((_local_8 + _arg_3), 0), (_arg_1.length - _arg_2));
            _arg_1.position = _local_10;
            var _local_6:Number = _local_10;
            var _local_4:String = ((("[Dump] total length: " + _arg_1.length) + ", original position: ") + _local_8);
            _local_7 = 0;
            while (_local_7 < _arg_2)
            {
                _local_5 = _arg_1.readUnsignedByte().toString(16);
                if (_local_5.length == 1)
                {
                    _local_5 = ("0" + _local_5);
                };
                if ((_local_7 % 16) == 0)
                {
                    _local_9 = (_local_6 + _local_7).toString(16);
                    _local_9 = ("00000000".substr(0, (8 - _local_9.length)) + _local_9);
                    _local_4 = (_local_4 + (("\r" + _local_9) + ": "));
                };
                _local_5 = (_local_5 + " ");
                _local_4 = (_local_4 + _local_5);
                _local_7++;
            };
            _arg_1.position = _local_8;
            trace(_local_4); //not popped
        }


        public function readSI8():int
        {
            resetBitsPending();
            return (readByte());
        }

        public function writeSI8(_arg_1:int):void
        {
            resetBitsPending();
            writeByte(_arg_1);
        }

        public function readSI16():int
        {
            resetBitsPending();
            return (readShort());
        }

        public function writeSI16(_arg_1:int):void
        {
            resetBitsPending();
            writeShort(_arg_1);
        }

        public function readSI32():int
        {
            resetBitsPending();
            return (readInt());
        }

        public function writeSI32(_arg_1:int):void
        {
            resetBitsPending();
            writeInt(_arg_1);
        }

        public function readUI8():uint
        {
            resetBitsPending();
            return (readUnsignedByte());
        }

        public function writeUI8(_arg_1:uint):void
        {
            resetBitsPending();
            writeByte(_arg_1);
        }

        public function readUI16():uint
        {
            resetBitsPending();
            return (readUnsignedShort());
        }

        public function writeUI16(_arg_1:uint):void
        {
            resetBitsPending();
            writeShort(_arg_1);
        }

        public function readUI24():uint
        {
            resetBitsPending();
            var _local_2:uint = readUnsignedShort();
            var _local_1:uint = readUnsignedByte();
            return ((_local_1 << 16) | _local_2);
        }

        public function writeUI24(_arg_1:uint):void
        {
            resetBitsPending();
            writeShort((_arg_1 & 0xFFFF));
            writeByte((_arg_1 >> 16));
        }

        public function readUI32():uint
        {
            resetBitsPending();
            return (readUnsignedInt());
        }

        public function writeUI32(_arg_1:uint):void
        {
            resetBitsPending();
            writeUnsignedInt(_arg_1);
        }

        public function readFIXED():Number
        {
            resetBitsPending();
            return (readInt() / 0x10000);
        }

        public function writeFIXED(_arg_1:Number):void
        {
            resetBitsPending();
            writeInt((_arg_1 * 0x10000));
        }

        public function readFIXED8():Number
        {
            resetBitsPending();
            return (readShort() / 0x0100);
        }

        public function writeFIXED8(_arg_1:Number):void
        {
            resetBitsPending();
            writeShort((_arg_1 * 0x0100));
        }

        public function readFLOAT():Number
        {
            resetBitsPending();
            return (readFloat());
        }

        public function writeFLOAT(_arg_1:Number):void
        {
            resetBitsPending();
            writeFloat(_arg_1);
        }

        public function readDOUBLE():Number
        {
            resetBitsPending();
            return (readDouble());
        }

        public function writeDOUBLE(_arg_1:Number):void
        {
            resetBitsPending();
            writeDouble(_arg_1);
        }

        public function readFLOAT16():Number
        {
            resetBitsPending();
            var _local_3:uint = readUnsignedShort();
            var _local_1:int = (((_local_3 & 0x8000) != 0) ? -1 : 1);
            var _local_4:uint = ((_local_3 >> 10) & 0x1F);
            var _local_2:uint = (_local_3 & 0x03FF);
            if (_local_4 == 0)
            {
                if (_local_2 == 0)
                {
                    return (0);
                };
                return ((_local_1 * Math.pow(2, (1 - 15))) * (_local_2 / 0x0400));
            };
            if (_local_4 == 31)
            {
                if (_local_2 == 0)
                {
                    return ((_local_1 < 0) ? Number.NEGATIVE_INFINITY : Infinity);
                };
                return (NaN);
            };
            return ((_local_1 * Math.pow(2, (_local_4 - 15))) * (1 + (_local_2 / 0x0400)));
        }

        public function writeFLOAT16(_arg_1:Number):void
        {
            _SafeStr_76.write(_arg_1, this);
        }

        public function readEncodedU32():uint
        {
            resetBitsPending();
            var _local_1:uint = readUnsignedByte();
            if ((_local_1 & 0x80))
            {
                _local_1 = ((_local_1 & 0x7F) | (readUnsignedByte() << 7));
                if ((_local_1 & 0x4000))
                {
                    _local_1 = ((_local_1 & 0x3FFF) | (readUnsignedByte() << 14));
                    if ((_local_1 & 0x200000))
                    {
                        _local_1 = ((_local_1 & 0x1FFFFF) | (readUnsignedByte() << 21));
                        if ((_local_1 & 0x10000000))
                        {
                            _local_1 = ((_local_1 & 0x0FFFFFFF) | (readUnsignedByte() << 28));
                        };
                    };
                };
            };
            return (_local_1);
        }

        public function writeEncodedU32(_arg_1:uint):void
        {
            var _local_2:uint;
            while (true)
            {
                _local_2 = (_arg_1 & 0x7F);
                _arg_1 = (_arg_1 >> 7);
                if (_arg_1 == 0)
                {
                    writeUI8(_local_2);
                    return;
                };
                writeUI8((_local_2 | 0x80));
            };
        }

        public function readUB(_arg_1:uint):uint
        {
            return (readBits(_arg_1));
        }

        public function writeUB(_arg_1:uint, _arg_2:uint):void
        {
            writeBits(_arg_1, _arg_2);
        }

        public function readSB(_arg_1:uint):int
        {
            var _local_2:uint = (32 - _arg_1);
            return ((readBits(_arg_1) << _local_2) >> _local_2);
        }

        public function writeSB(_arg_1:uint, _arg_2:int):void
        {
            writeBits(_arg_1, _arg_2);
        }

        public function readFB(_arg_1:uint):Number
        {
            return (readSB(_arg_1) / 0x10000);
        }

        public function writeFB(_arg_1:uint, _arg_2:Number):void
        {
            writeSB(_arg_1, (_arg_2 * 0x10000));
        }

        public function readString():String
        {
            var _local_1:uint = position;
            do
            {
            } while (this[_local_1++]);
            resetBitsPending();
            return (readUTFBytes((_local_1 - position)));
        }

        public function writeString(_arg_1:String):void
        {
            if (((_arg_1) && (_arg_1.length > 0)))
            {
                writeUTFBytes(_arg_1);
            };
            writeByte(0);
        }

        public function readLANGCODE():uint
        {
            resetBitsPending();
            return (readUnsignedByte());
        }

        public function writeLANGCODE(_arg_1:uint):void
        {
            resetBitsPending();
            writeByte(_arg_1);
        }

        public function readRGB():uint
        {
            resetBitsPending();
            var _local_1:uint = readUnsignedByte();
            var _local_3:uint = readUnsignedByte();
            var _local_2:uint = readUnsignedByte();
            return (((0xFF000000 | (_local_1 << 16)) | (_local_3 << 8)) | _local_2);
        }

        public function writeRGB(_arg_1:uint):void
        {
            resetBitsPending();
            writeByte(((_arg_1 >> 16) & 0xFF));
            writeByte(((_arg_1 >> 8) & 0xFF));
            writeByte((_arg_1 & 0xFF));
        }

        public function readRGBA():uint
        {
            resetBitsPending();
            var _local_2:uint = (readRGB() & 0xFFFFFF);
            var _local_1:uint = readUnsignedByte();
            return ((_local_1 << 24) | _local_2);
        }

        public function writeRGBA(_arg_1:uint):void
        {
            resetBitsPending();
            writeRGB(_arg_1);
            writeByte(((_arg_1 >> 24) & 0xFF));
        }

        public function readARGB():uint
        {
            resetBitsPending();
            var _local_1:uint = readUnsignedByte();
            var _local_2:uint = (readRGB() & 0xFFFFFF);
            return ((_local_1 << 24) | _local_2);
        }

        public function writeARGB(_arg_1:uint):void
        {
            resetBitsPending();
            writeByte(((_arg_1 >> 24) & 0xFF));
            writeRGB(_arg_1);
        }

        public function readRECT():SWFRectangle
        {
            return (new SWFRectangle(this));
        }

        public function writeRECT(_arg_1:SWFRectangle):void
        {
            _arg_1.publish(this);
        }

        public function readMATRIX():SWFMatrix
        {
            return (new SWFMatrix(this));
        }

        public function writeMATRIX(_arg_1:SWFMatrix):void
        {
            var _local_4:uint;
            var _local_3:uint;
            this.resetBitsPending();
            var _local_2:Boolean = ((!(_arg_1.scaleX == 1)) || (!(_arg_1.scaleY == 1)));
            var _local_5:Boolean = ((!(_arg_1.rotateSkew0 == 0)) || (!(_arg_1.rotateSkew1 == 0)));
            writeBits(1, ((_local_2) ? 1 : 0));
            if (_local_2)
            {
                if (((_arg_1.scaleX == 0) && (_arg_1.scaleY == 0)))
                {
                    _local_4 = 1;
                }
                else
                {
                    _local_4 = calculateMaxBits(true, [(_arg_1.scaleX * 0x10000), (_arg_1.scaleY * 0x10000)]);
                };
                writeUB(5, _local_4);
                writeFB(_local_4, _arg_1.scaleX);
                writeFB(_local_4, _arg_1.scaleY);
            };
            writeBits(1, ((_local_5) ? 1 : 0));
            if (_local_5)
            {
                _local_3 = calculateMaxBits(true, [(_arg_1.rotateSkew0 * 0x10000), (_arg_1.rotateSkew1 * 0x10000)]);
                writeUB(5, _local_3);
                writeFB(_local_3, _arg_1.rotateSkew0);
                writeFB(_local_3, _arg_1.rotateSkew1);
            };
            var _local_6:uint = calculateMaxBits(true, [_arg_1._SafeStr_290, _arg_1._SafeStr_291]);
            writeUB(5, _local_6);
            writeSB(_local_6, _arg_1._SafeStr_290);
            writeSB(_local_6, _arg_1._SafeStr_291);
        }

        public function readCXFORM():SWFColorTransform
        {
            return (new SWFColorTransform(this));
        }

        public function writeCXFORM(_arg_1:SWFColorTransform):void
        {
            _arg_1.publish(this);
        }

        public function readCXFORMWITHALPHA():SWFColorTransformWithAlpha
        {
            return (new SWFColorTransformWithAlpha(this));
        }

        public function writeCXFORMWITHALPHA(_arg_1:SWFColorTransformWithAlpha):void
        {
            _arg_1.publish(this);
        }

        public function readSHAPE(_arg_1:Number=20):SWFShape
        {
            return (new SWFShape(this, 1, _arg_1));
        }

        public function writeSHAPE(_arg_1:SWFShape):void
        {
            _arg_1.publish(this);
        }

        public function readSHAPEWITHSTYLE(_arg_1:uint=1, _arg_2:Number=20):SWFShapeWithStyle
        {
            return (new SWFShapeWithStyle(this, _arg_1, _arg_2));
        }

        public function writeSHAPEWITHSTYLE(_arg_1:SWFShapeWithStyle, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readSTRAIGHTEDGERECORD(_arg_1:uint):SWFShapeRecordStraightEdge
        {
            return (new SWFShapeRecordStraightEdge(this, _arg_1));
        }

        public function writeSTRAIGHTEDGERECORD(_arg_1:SWFShapeRecordStraightEdge):void
        {
            _arg_1.publish(this);
        }

        public function readCURVEDEDGERECORD(_arg_1:uint):SWFShapeRecordCurvedEdge
        {
            return (new SWFShapeRecordCurvedEdge(this, _arg_1));
        }

        public function writeCURVEDEDGERECORD(_arg_1:SWFShapeRecordCurvedEdge):void
        {
            _arg_1.publish(this);
        }

        public function readSTYLECHANGERECORD(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint=1):SWFShapeRecordStyleChange
        {
            return (new SWFShapeRecordStyleChange(this, _arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function writeSTYLECHANGERECORD(_arg_1:SWFShapeRecordStyleChange, _arg_2:uint, _arg_3:uint, _arg_4:uint=1):void
        {
            _arg_1._SafeStr_292 = _arg_2;
            _arg_1._SafeStr_293 = _arg_3;
            _arg_1.publish(this, _arg_4);
        }

        public function readFILLSTYLE(_arg_1:uint=1):SWFFillStyle
        {
            return (new SWFFillStyle(this, _arg_1));
        }

        public function writeFILLSTYLE(_arg_1:SWFFillStyle, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readLINESTYLE(_arg_1:uint=1):SWFLineStyle
        {
            return (new SWFLineStyle(this, _arg_1));
        }

        public function writeLINESTYLE(_arg_1:SWFLineStyle, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readLINESTYLE2(_arg_1:uint=1):SWFLineStyle2
        {
            return (new SWFLineStyle2(this, _arg_1));
        }

        public function writeLINESTYLE2(_arg_1:SWFLineStyle2, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readBUTTONRECORD(_arg_1:uint=1):SWFButtonRecord
        {
            if (readUI8() == 0)
            {
                return (null);
            };
            position--;
            return (new SWFButtonRecord(this, _arg_1));
        }

        public function writeBUTTONRECORD(_arg_1:SWFButtonRecord, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readBUTTONCONDACTION():SWFButtonCondAction
        {
            return (new SWFButtonCondAction(this));
        }

        public function writeBUTTONCONDACTION(_arg_1:SWFButtonCondAction):void
        {
            _arg_1.publish(this);
        }

        public function readFILTER():IFilter
        {
            var _local_1:uint = readUI8();
            var _local_2:IFilter = _SafeStr_83.create(_local_1);
            _local_2.parse(this);
            return (_local_2);
        }

        public function writeFILTER(_arg_1:IFilter):void
        {
            writeUI8(_arg_1.id);
            _arg_1.publish(this);
        }

        public function readTEXTRECORD(_arg_1:uint, _arg_2:uint, _arg_3:SWFTextRecord=null, _arg_4:uint=1):SWFTextRecord
        {
            if (readUI8() == 0)
            {
                return (null);
            };
            position--;
            return (new SWFTextRecord(this, _arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function writeTEXTRECORD(_arg_1:SWFTextRecord, _arg_2:uint, _arg_3:uint, _arg_4:SWFTextRecord=null, _arg_5:uint=1):void
        {
            _arg_1.publish(this, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function readGLYPHENTRY(_arg_1:uint, _arg_2:uint):SWFGlyphEntry
        {
            return (new SWFGlyphEntry(this, _arg_1, _arg_2));
        }

        public function writeGLYPHENTRY(_arg_1:SWFGlyphEntry, _arg_2:uint, _arg_3:uint):void
        {
            _arg_1.publish(this, _arg_2, _arg_3);
        }

        public function readZONERECORD():SWFZoneRecord
        {
            return (new SWFZoneRecord(this));
        }

        public function writeZONERECORD(_arg_1:SWFZoneRecord):void
        {
            _arg_1.publish(this);
        }

        public function readZONEDATA():SWFZoneData
        {
            return (new SWFZoneData(this));
        }

        public function writeZONEDATA(_arg_1:SWFZoneData):void
        {
            _arg_1.publish(this);
        }

        public function readKERNINGRECORD(_arg_1:Boolean):SWFKerningRecord
        {
            return (new SWFKerningRecord(this, _arg_1));
        }

        public function writeKERNINGRECORD(_arg_1:SWFKerningRecord, _arg_2:Boolean):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readGRADIENT(_arg_1:uint=1):SWFGradient
        {
            return (new SWFGradient(this, _arg_1));
        }

        public function writeGRADIENT(_arg_1:SWFGradient, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readFOCALGRADIENT(_arg_1:uint=1):SWFFocalGradient
        {
            return (new SWFFocalGradient(this, _arg_1));
        }

        public function writeFOCALGRADIENT(_arg_1:SWFFocalGradient, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readGRADIENTRECORD(_arg_1:uint=1):SWFGradientRecord
        {
            return (new SWFGradientRecord(this, _arg_1));
        }

        public function writeGRADIENTRECORD(_arg_1:SWFGradientRecord, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHFILLSTYLE(_arg_1:uint=1):SWFMorphFillStyle
        {
            return (new SWFMorphFillStyle(this, _arg_1));
        }

        public function writeMORPHFILLSTYLE(_arg_1:SWFMorphFillStyle, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHLINESTYLE(_arg_1:uint=1):SWFMorphLineStyle
        {
            return (new SWFMorphLineStyle(this, _arg_1));
        }

        public function writeMORPHLINESTYLE(_arg_1:SWFMorphLineStyle, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHLINESTYLE2(_arg_1:uint=1):SWFMorphLineStyle2
        {
            return (new SWFMorphLineStyle2(this, _arg_1));
        }

        public function writeMORPHLINESTYLE2(_arg_1:SWFMorphLineStyle2, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHGRADIENT(_arg_1:uint=1):SWFMorphGradient
        {
            return (new SWFMorphGradient(this, _arg_1));
        }

        public function writeMORPHGRADIENT(_arg_1:SWFMorphGradient, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHFOCALGRADIENT(_arg_1:uint=1):SWFMorphFocalGradient
        {
            return (new SWFMorphFocalGradient(this, _arg_1));
        }

        public function writeMORPHFOCALGRADIENT(_arg_1:SWFMorphFocalGradient, _arg_2:uint=1):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readMORPHGRADIENTRECORD():SWFMorphGradientRecord
        {
            return (new SWFMorphGradientRecord(this));
        }

        public function writeMORPHGRADIENTRECORD(_arg_1:SWFMorphGradientRecord):void
        {
            _arg_1.publish(this);
        }

        public function readACTIONRECORD():IAction
        {
            var _local_2:IAction;
            var _local_1:uint;
            var _local_3:uint = readUI8();
            if (_local_3 != 0)
            {
                _local_1 = ((_local_3 >= 128) ? readUI16() : 0);
                _local_2 = _SafeStr_85.create(_local_3, _local_1);
                _local_2.parse(this);
            };
            return (_local_2);
        }

        public function writeACTIONRECORD(_arg_1:IAction):void
        {
            _arg_1.publish(this);
        }

        public function readACTIONVALUE():SWFActionValue
        {
            return (new SWFActionValue(this));
        }

        public function writeACTIONVALUE(_arg_1:SWFActionValue):void
        {
            _arg_1.publish(this);
        }

        public function readREGISTERPARAM():SWFRegisterParam
        {
            return (new SWFRegisterParam(this));
        }

        public function writeREGISTERPARAM(_arg_1:SWFRegisterParam):void
        {
            _arg_1.publish(this);
        }

        public function readSYMBOL():SWFSymbol
        {
            return (new SWFSymbol(this));
        }

        public function writeSYMBOL(_arg_1:SWFSymbol):void
        {
            _arg_1.publish(this);
        }

        public function readSOUNDINFO():SWFSoundInfo
        {
            return (new SWFSoundInfo(this));
        }

        public function writeSOUNDINFO(_arg_1:SWFSoundInfo):void
        {
            _arg_1.publish(this);
        }

        public function readSOUNDENVELOPE():SWFSoundEnvelope
        {
            return (new SWFSoundEnvelope(this));
        }

        public function writeSOUNDENVELOPE(_arg_1:SWFSoundEnvelope):void
        {
            _arg_1.publish(this);
        }

        public function readCLIPACTIONS(_arg_1:uint):SWFClipActions
        {
            return (new SWFClipActions(this, _arg_1));
        }

        public function writeCLIPACTIONS(_arg_1:SWFClipActions, _arg_2:uint):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readCLIPACTIONRECORD(_arg_1:uint):SWFClipActionRecord
        {
            var _local_2:uint = position;
            var _local_3:uint = ((_arg_1 >= 6) ? readUI32() : readUI16());
            if (_local_3 == 0)
            {
                return (null);
            };
            position = _local_2;
            return (new SWFClipActionRecord(this, _arg_1));
        }

        public function writeCLIPACTIONRECORD(_arg_1:SWFClipActionRecord, _arg_2:uint):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readCLIPEVENTFLAGS(_arg_1:uint):SWFClipEventFlags
        {
            return (new SWFClipEventFlags(this, _arg_1));
        }

        public function writeCLIPEVENTFLAGS(_arg_1:SWFClipEventFlags, _arg_2:uint):void
        {
            _arg_1.publish(this, _arg_2);
        }

        public function readTagHeader():SWFRecordHeader
        {
            var _local_2:uint = position;
            var _local_1:uint = readUI16();
            var _local_3:uint = (_local_1 & 0x3F);
            if (_local_3 == 63)
            {
                _local_3 = readSI32();
            };
            return (new SWFRecordHeader((_local_1 >> 6), _local_3, (position - _local_2)));
        }

        public function writeTagHeader(_arg_1:uint, _arg_2:uint, _arg_3:Boolean=false):void
        {
            if (((_arg_2 < 63) && (!(_arg_3))))
            {
                writeUI16(((_arg_1 << 6) | _arg_2));
            }
            else
            {
                writeUI16(((_arg_1 << 6) | 0x3F));
                writeSI32(_arg_2);
            };
        }

        public function swfUncompress(_arg_1:String, _arg_2:uint=0):void
        {
            var _local_4:uint;
            var _local_3:uint = position;
            var _local_5:ByteArray = new ByteArray();
            if (_arg_1 == "zlib")
            {
                readBytes(_local_5);
                _local_5.position = 0;
                _local_5.uncompress();
            }
            else
            {
                if (_arg_1 == "lzma")
                {
                    _local_4 = 0;
                    while (_local_4 < 5)
                    {
                        _local_5.writeByte(this[(_local_4 + 12)]);
                        _local_4++;
                    };
                    _local_5.endian = "littleEndian";
                    _local_5.writeUnsignedInt((_arg_2 - 8));
                    _local_5.writeUnsignedInt(0);
                    position = 17;
                    readBytes(_local_5, 13);
                    _local_5.position = 0;
                    _local_5.uncompress(_arg_1);
                }
                else
                {
                    throw (new Error(("Unknown compression method: " + _arg_1)));
                };
            };
            length = (position = _local_3);
            writeBytes(_local_5);
            position = _local_3;
        }

        public function swfCompress(_arg_1:String):void
        {
            var _local_3:uint = position;
            var _local_5:ByteArray = new ByteArray();
            if (_arg_1 == "zlib")
            {
                readBytes(_local_5);
                _local_5.position = 0;
                _local_5.compress();
            }
            else
            {
                if (_arg_1 == "lzma")
                {
                    throw (new Error("Can't publish LZMA compressed SWFs"));
                };

                throw (new Error(("Unknown compression method: " + _arg_1)));
            };

            length = position = _local_3;
            writeBytes(_local_5);
        }

        public function readRawTag():SWFRawTag
        {
            return (new SWFRawTag(this));
        }

        public function skipBytes(_arg_1:uint):void
        {
            position = (position + _arg_1);
        }


    }
}