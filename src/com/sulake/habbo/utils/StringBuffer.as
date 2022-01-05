package com.sulake.habbo.utils
{
   import flash.utils.ByteArray;

    public class StringBuffer
   {
      protected var buffer:ByteArray = new ByteArray();
      protected var backBuffer:ByteArray = new ByteArray();

      public function StringBuffer(_arg_1:uint = 0, _arg_2:String = null)
      {
         buffer.endian = "bigEndian";
         buffer.length = _arg_1;
         if (_arg_2)
         {
            buffer.writeUTFBytes(_arg_2);
         }
      }

      public function appendByteArray(_arg_1:ByteArray, _arg_2:uint = 0, _arg_3:uint = 0):StringBuffer
      {
         var _local_5:uint = uint(_arg_2 + _arg_3);
         var _local_4:uint = _arg_1.length;
         if (_local_5 > _local_4)
         {
            _local_5 = _local_4;
         }
         if (_arg_2 >= _local_5)
         {
            return this;
         }
         buffer.writeBytes(_arg_1,_arg_2,_local_5 - _arg_2);
         return this;
      }

      public function appendChar(_arg_1:int):StringBuffer
      {
         buffer.writeByte(_arg_1);
         return this;
      }

      public function appendChars(... rest):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in rest)
         {
            _local_3.writeByte(int(_local_2));
         }
         return this;
      }

      public function appendCharArray(_arg_1:Array):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in _arg_1)
         {
            _local_3.writeByte(int(_local_2));
         }
         return this;
      }

      public function appendCharVectorI(_arg_1:Vector.<int>):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:int in _arg_1)
         {
            _local_3.writeByte(_local_2);
         }
         return this;
      }

      public function appendCharVectorU(_arg_1:Vector.<uint>):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:uint in _arg_1)
         {
            _local_3.writeByte(_local_2);
         }
         return this;
      }

      public function appendInt(_arg_1:int):StringBuffer
      {
         buffer.writeInt(_arg_1);
         return this;
      }

      public function appendInts(... rest):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in rest)
         {
            _local_3.writeInt(int(_local_2));
         }
         return this;
      }

      public function appendIntArray(_arg_1:Array):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in _arg_1)
         {
            _local_3.writeInt(int(_local_2));
         }
         return this;
      }

      public function appendIntVector(_arg_1:Vector.<int>):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:int in _arg_1)
         {
            _local_3.writeInt(_local_2);
         }
         return this;
      }

      public function appendString(_arg_1:*):StringBuffer
      {
         buffer.writeUTFBytes(String(_arg_1));
         return this;
      }

      public function appendStrings(... rest):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in rest)
         {
            _local_3.writeUTFBytes(String(_local_2));
         }
         return this;
      }

      public function appendStringArray(_arg_1:Array):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:* in _arg_1)
         {
            _local_3.writeUTFBytes(String(_local_2));
         }
         return this;
      }

      public function appendStringBuffer(_arg_1:StringBuffer, _arg_2:uint = 0, _arg_3:uint = 0):StringBuffer
      {
         var _local_4:ByteArray = _arg_1.buffer;
         var _local_5:uint = _local_4.length;
         var _local_6:uint = uint(_arg_2 + _arg_3);
         if (_local_6 > _local_5)
         {
            _local_6 = _local_5;
         }
         if (_arg_2 >= _local_6)
         {
            return this;
         }
         buffer.writeBytes(_local_4,_arg_2,_local_6 - _arg_2);
         return this;
      }

      public function appendStringVector(_arg_1:Vector.<String>):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:String in _arg_1)
         {
            _local_3.writeUTFBytes(String(_local_2));
         }
         return this;
      }

      public function appendUintVector(_arg_1:Vector.<uint>):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         for each(var _local_2:uint in _arg_1)
         {
            _local_3.writeInt(_local_2);
         }
         return this;
      }

      public function byteAt(_arg_1:uint):int
      {
         if (_arg_1 < buffer.length)
         {
            return buffer[_arg_1];
         }
         return 0;
      }

      public function charAt(_arg_1:uint):String
      {
         return toString().charAt(_arg_1);
      }

      public function clear():void
      {
         if (buffer.length > 0)
         {
            buffer.clear();
         }
         if (backBuffer.length > 0)
         {
            backBuffer.clear();
         }
      }

      public function count(_arg_1:String):uint
      {
         var _local_7:uint = 0;
         var _local_5:int = 0;
         if (!_arg_1)
         {
            return 0;
         }
         var _local_3:ByteArray = buffer;
         var _local_4:ByteArray = backBuffer;
         var _local_2:uint = _local_3.position;
         var _local_6:uint = _local_3.length;
         _local_4.clear();
         _local_4.writeUTFBytes(_arg_1);
         _local_3.position = 0;
         while (_local_6--)
         {
            if (_local_3.readByte() == _local_4[_local_7])
            {
               if (++_local_7 == _local_4.length)
               {
                  _local_5++;
                  _local_7 = uint(0);
               }
            }
            else
            {
               _local_7 = uint(0);
            }
         }
         _local_7 = uint(_local_3.position - _local_7);
         _local_3.position = _local_2;
         return _local_5;
      }

      public function countChar(_arg_1:int):uint
      {
         var _local_5:int = 0;
         var _local_3:uint = 0;
         var _local_2:ByteArray = null;
         _local_2 = buffer;
         var _local_4:uint = _local_2.length;
         while (_local_5 < _local_4)
         {
            _local_3 += uint(_local_2[_local_5] == _arg_1);
            ++_local_5;
         }
         return _local_3;
      }

      public function deleteCharAt(_arg_1:uint):void
      {
         var _local_3:ByteArray = null;
         _local_3 = buffer;
         var _local_4:uint = _local_3.length - 1;
         if (int(!length) | int(_arg_1 >= _local_4))
         {
            return;
         }
         var _local_2:uint = _local_3.position;
         _local_3.position = _arg_1;
         _local_3.writeBytes(_local_3,_arg_1 + 1,_local_4 - _arg_1);
         _local_3.position = _local_2 - 1;
      }

      public function deleteCharsAt(_arg_1:uint, _arg_2:uint):void
      {
         var _local_4:ByteArray = buffer;
         var _local_5:uint = _local_4.length - _arg_2;
         if (int(!length) | int(_arg_1 >= _local_5))
         {
            return;
         }
         var _local_3:uint = _local_4.position;
         _local_4.position = _arg_1;
         _local_4.writeBytes(_local_4,_arg_1 + _arg_2,_local_5 - _arg_1);
         _local_4.position = _local_3 - _arg_2;
      }

      public function empty():Boolean
      {
         return !buffer.position;
      }

      public function getBytesAt(_arg_1:uint, _arg_2:uint, _arg_3:ByteArray = null, _arg_4:uint = 0):ByteArray
      {
         if (!_arg_3)
         {
            _arg_3 = new ByteArray();
         }
         if (_arg_4 < _arg_3.length)
         {
            _arg_4 = _arg_3.length;
         }
         _arg_3.writeBytes(buffer,_arg_1,_arg_2);
         return _arg_3;
      }

      public function insertByteArray(_arg_1:uint, _arg_2:ByteArray, _arg_3:int = 0, _arg_4:int = 0):StringBuffer
      {
         var _local_6:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendByteArray(_arg_2,_arg_3,_arg_4);
            return this;
         }
         var _local_7:uint = _local_6.position;
         if (_arg_1 < _local_6.position)
         {
            _local_6.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_6,_arg_1,0);
         var _local_5:uint = _arg_2.length;
         if (_arg_4 > _local_5)
         {
            _arg_4 = _local_5;
         }
         if (_arg_3 > _arg_4)
         {
            return this;
         }
         _local_6.writeBytes(_arg_2,_arg_3,_arg_4);
         _local_6.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertChar(_arg_1:uint, _arg_2:int):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendChar(_arg_2);
            return this;
         }
         var _local_4:uint = _local_3.position;
         if (_arg_1 < _local_3.position)
         {
            _local_3.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_3,_arg_1,0);
         _local_3.writeByte(_arg_2);
         _local_3.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertChars(_arg_1:uint, ... rest):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendCharArray(rest);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in rest)
         {
            _local_4.writeByte(int(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertCharArray(_arg_1:uint, _arg_2:Array):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendCharArray(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in _arg_2)
         {
            _local_4.writeByte(int(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertCharVectorI(_arg_1:uint, _arg_2:Vector.<int>):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendCharVectorI(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:int in _arg_2)
         {
            _local_4.writeByte(_local_3);
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertCharVectorU(_arg_1:uint, _arg_2:Vector.<uint>):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendCharVectorU(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:uint in _arg_2)
         {
            _local_4.writeByte(_local_3);
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertInt(_arg_1:uint, _arg_2:int):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendInt(_arg_2);
            return this;
         }
         var _local_4:uint = _local_3.position;
         if (_arg_1 < _local_3.position)
         {
            _local_3.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_3,_arg_1,0);
         _local_3.writeInt(_arg_2);
         _local_3.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertInts(_arg_1:uint, ... rest):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendIntArray(rest);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in rest)
         {
            _local_4.writeInt(int(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertIntArray(_arg_1:uint, _arg_2:Array):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendIntArray(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in _arg_2)
         {
            _local_4.writeInt(int(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertIntVector(_arg_1:uint, _arg_2:Vector.<int>):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendIntVector(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:int in _arg_2)
         {
            _local_4.writeInt(_local_3);
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertString(_arg_1:uint, _arg_2:*):StringBuffer
      {
         var _local_3:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendString(_arg_2);
            return this;
         }
         var _local_4:uint = _local_3.position;
         if (_arg_1 < _local_3.position)
         {
            _local_3.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_3,_arg_1,0);
         _local_3.writeUTFBytes(String(_arg_2));
         _local_3.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertStrings(_arg_1:uint, ... rest):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendStringArray(rest);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in rest)
         {
            _local_4.writeUTFBytes(String(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertStringArray(_arg_1:uint, _arg_2:Array):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendStringArray(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:* in _arg_2)
         {
            _local_4.writeUTFBytes(String(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertStringBuffer(_arg_1:uint, _arg_2:StringBuffer, _arg_3:int = 0, _arg_4:int = 0):StringBuffer
      {
         var _local_5:ByteArray = null;
         var _local_7:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendStringBuffer(_arg_2,_arg_3,_arg_4);
            return this;
         }
         var _local_8:uint = _local_7.position;
         if (_arg_1 < _local_7.position)
         {
            _local_7.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_7,_arg_1,0);
         _local_5 = _arg_2.buffer;
         var _local_6:uint = _local_5.length;
         if (_arg_4 > _local_6)
         {
            _arg_4 = _local_6;
         }
         if (_arg_3 > _arg_4)
         {
            return this;
         }
         _local_7.writeBytes(_local_5,_arg_3,_arg_4);
         _local_7.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertStringVector(_arg_1:uint, _arg_2:Vector.<String>):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendStringVector(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:String in _arg_2)
         {
            _local_4.writeUTFBytes(String(_local_3));
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function insertUintVector(_arg_1:uint, _arg_2:Vector.<uint>):StringBuffer
      {
         var _local_4:ByteArray = this.buffer;
         if (_arg_1 > length)
         {
            appendUintVector(_arg_2);
            return this;
         }
         var _local_5:uint = _local_4.position;
         if (_arg_1 < _local_4.position)
         {
            _local_4.position = _arg_1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_local_4,_arg_1,0);
         for each(var _local_3:uint in _arg_2)
         {
            _local_4.writeInt(_local_3);
         }
         _local_4.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }

      public function indexOf(_arg_1:String, _arg_2:uint = 0):Number
      {
         var _local_7:uint = 0;
         if (!_arg_1 || _arg_2 >= length)
         {
            return -1;
         }
         var _local_4:ByteArray = buffer;
         var _local_5:ByteArray = backBuffer;
         var _local_3:uint = _local_4.position;
         var _local_6:uint = _local_4.length;
         _local_5.clear();
         _local_5.writeUTFBytes(_arg_1);
         _local_4.position = 0;
         while (_local_6--)
         {
            if (_local_4.readByte() == _local_5[_local_7])
            {
               if (++_local_7 == _local_5.length)
               {
                  break;
               }
            }
            else
            {
               _local_7 = uint(0);
            }
         }
         _local_7 = uint(_local_4.position - _local_7);
         _local_4.position = _local_3;
         if (~_local_6)
         {
            return Number(_local_7);
         }
         return -1;
      }

      public function indexOfChar(_arg_1:int, _arg_2:uint = 0):Number
      {
         if (_arg_2 >= length)
         {
            return -1;
         }
         var _local_4:ByteArray = buffer;
         var _local_3:uint = _local_4.position;
         var _local_5:uint = _local_4.length;
         _local_4.position = 0;
         var _local_6:uint = 0;
         while (_local_5--)
         {
            if (_local_4.readByte() == _arg_1)
            {
               break;
            }
         }
         _local_6 = _local_4.position - _local_6;
         _local_4.position = _local_3;
         if (~_local_5)
         {
            return Number(_local_6);
         }
         return -1;
      }

      public function lastIndexOf(_arg_1:String, _arg_2:uint = 4294967295):Number
      {
         var _local_7:uint = 0;
         var _local_8:uint = 0;
         if (!_arg_1 || _arg_2 >= length)
         {
            return -1;
         }
         var _local_4:ByteArray = buffer;
         var _local_5:ByteArray = backBuffer;
         var _local_3:uint = _local_4.position;
         var _local_6:uint = uint(_local_4.length);
         _local_5.clear();
         _local_5.writeUTFBytes(_arg_1);
         _local_4.position = 0;
         if (_arg_2 < _local_6)
         {
            _local_6 = _arg_2;
         }
         while (_local_6--)
         {
            if (_local_4.readByte() == _local_5[_local_7])
            {
               if (++_local_7 == _local_5.length)
               {
                  _local_8 = uint(_local_4.position - _local_7);
                  _local_7 = uint(0);
               }
            }
            else
            {
               _local_7 = uint(0);
            }
         }
         _local_4.position = _local_3;
         if (~_local_6)
         {
            return Number(_local_8);
         }
         return -1;
      }

      public function lastIndexOfChar(_arg_1:int, _arg_2:uint = 4294967295):Number
      {
         var _local_3:ByteArray = null;
         if (_arg_2 >= length)
         {
            return -1;
         }
         _local_3 = buffer;
         var _local_4:uint = uint(_local_3.length);
         if (_arg_2 < _local_4)
         {
            _local_4 = _arg_2;
         }
         while (_local_4--)
         {
            if (_local_3[_local_4] == _arg_1)
            {
               return Number(_local_4);
            }
         }
         return -1;
      }

      public function get length():uint
      {
         return buffer.length;
      }

      public function set length(_arg_1:uint):void
      {
         buffer.length = _arg_1;
         if (_arg_1 < buffer.position)
         {
            buffer.position = _arg_1;
         }
      }

      public function replace(_arg_1:uint, _arg_2:String):StringBuffer
      {
         var _local_3:uint = buffer.position;
         buffer.position = _arg_1;
         buffer.writeUTFBytes(String(_arg_2));
         if (buffer.position < _local_3)
         {
            buffer.position = _local_3;
         }
         return this;
      }

      public function replaceBytes(_arg_1:uint, _arg_2:uint, _arg_3:ByteArray, _arg_4:uint = 0):StringBuffer
      {
         var _local_5:ByteArray = buffer;
         var _local_7:uint = _arg_4;
         var _local_6:uint = _arg_3.length;
         if (_arg_2 > _local_5.length)
         {
            _arg_2 = _local_5.length;
         }
         while (int(_arg_1 < _arg_2) & int(_local_7 < _local_6))
         {
            _local_5[_arg_1++] = _arg_3[_local_7++];
         }
         return this;
      }

      public function replaceChar(_arg_1:int, _arg_2:int):uint
      {
         var _local_6:int = 0;
         var _local_4:int = 0;
         var _local_3:ByteArray = buffer;
         var _local_5:uint = buffer.length;
         while (_local_6 < _local_5)
         {
            if (_local_3[_local_6] == _arg_1)
            {
               _local_4++;
               _local_3[_local_6] = _arg_2;
            }
            _local_6++;
         }
         return _local_4;
      }

      public function replaceCharVoid(_arg_1:int, _arg_2:int):StringBuffer
      {
         var _local_5:int = 0;
         var _local_3:ByteArray = buffer;
         var _local_4:uint = buffer.length;
         while (_local_5 < _local_4)
         {
            if (_local_3[_local_5] == _arg_1)
            {
               _local_3[_local_5] = _arg_2;
            }
            _local_5++;
         }
         return this;
      }

      public function replaceFirstChar(_arg_1:int, _arg_2:int):StringBuffer
      {
         var _local_5:int = 0;
         var _local_3:ByteArray = buffer;
         var _local_4:uint = buffer.length;
         while (_local_5 < _local_4)
         {
            if (_local_3[_local_5] == _arg_1)
            {
               _local_3[_local_5] = _arg_2;
               return this;
            }
            _local_5++;
         }
         return this;
      }

      public function replaceLastChar(_arg_1:int, _arg_2:int):StringBuffer
      {
         var _local_3:ByteArray = buffer;
         var _local_4:uint = buffer.length;
         while (_local_4--)
         {
            if (_local_3[_local_4] == _arg_1)
            {
               _local_3[_local_4] = _arg_2;
               return this;
            }
         }
         return this;
      }

      public function replaceNthChar(_arg_1:int, _arg_2:int, _arg_3:uint):StringBuffer
      {
         var _local_7:int = 0;
         var _local_5:int = 0;
         var _local_4:ByteArray = buffer;
         var _local_6:uint = buffer.length;
         while (_local_7 < _local_6)
         {
            if (_local_4[_local_7] == _arg_1)
            {
               if (_local_5++ == _arg_3)
               {
                  _local_4[_local_7] = _arg_2;
                  return this;
               }
            }
            _local_7++;
         }
         return this;
      }

      public function replaceRange(_arg_1:uint, _arg_2:uint, _arg_3:String, _arg_4:uint = 0):StringBuffer
      {
         var _local_5:ByteArray = buffer;
         var _local_7:* = _arg_4;
         var _local_6:uint = _arg_3.length;
         if (_arg_2 > _local_5.length)
         {
            _arg_2 = _local_5.length;
         }
         while (int(_arg_1 < _arg_2) & int(_local_7 < _local_6))
         {
            _local_5[_arg_1++] = _arg_3.charCodeAt(_local_7++);
         }
         return this;
      }

      public function reset(_arg_1:uint = 0):ByteArray
      {
         var _local_2:ByteArray = buffer;
         buffer = new ByteArray();
         backBuffer = new ByteArray();
         buffer.length = _arg_1;
         return _local_2;
      }

      public function reverse():StringBuffer
      {
         var _local_3:int = 0;
         var _local_2:int = 0;
         var _local_1:ByteArray = null;
         _local_1 = buffer;
         var _local_4:uint = _local_1.length;
         while (_local_3 < _local_4)
         {
            _local_2 = _local_1[_local_3];
            _local_1[_local_3] = _local_1[_local_4];
            _local_1[_local_4] = _local_2;
            _local_3++;
            --_local_4;
         }
         return this;
      }

      public function setByteAt(_arg_1:uint, _arg_2:int):StringBuffer
      {
         if (_arg_1 < buffer.length)
         {
            buffer[_arg_1] = _arg_2;
         }
         return this;
      }

      public function setCharAt(_arg_1:uint, _arg_2:String):StringBuffer
      {
         if (!_arg_2 || _arg_2.length !== 1)
         {
            throw new ArgumentError("Char length must be 1.");
         }
         if (_arg_1 >= length)
         {
            throw new ArgumentError("Index " + _arg_1 + " outside range " + length + ".");
         }
         backBuffer.clear();
         if (_arg_1)
         {
            backBuffer.writeUTFBytes(toString(0,_arg_1 - 1));
         }
         backBuffer.writeUTFBytes(_arg_2);
         backBuffer.writeUTFBytes(toString(_arg_1 + 1));
         buffer.clear();
         buffer.writeBytes(backBuffer,0,backBuffer.length);
         backBuffer = new ByteArray();
         return this;
      }

      public function size():uint
      {
         var _local_2:ByteArray = buffer;
         if (!_local_2.length)
         {
            return 0;
         }
         var _local_1:uint = _local_2.position;
         var _local_3:uint = _local_2.length;
         _local_2.position = 0;
         while (_local_3 && _local_2.readByte())
         {
            _local_3--;
         }
         var _local_4:uint = _local_2.position;
         _local_2.position = _local_1;
         return _local_4 - 1 * (int(_local_3 != 0));
      }

      public function subbuf(_arg_1:uint = 0, _arg_2:uint = 4294967295):StringBuffer
      {
         var _local_3:StringBuffer = new StringBuffer();
         _local_3.appendStringBuffer(this,_arg_1,_arg_2);
         return _local_3;
      }

      public function subbuffer(_arg_1:uint, _arg_2:uint = 4294967295):StringBuffer
      {
         var _local_3:StringBuffer = new StringBuffer();
         var _local_4:uint = length;
         if (_arg_2 > _local_4)
         {
            _arg_2 = _local_4;
         }
         _local_3.appendStringBuffer(this,_arg_1,_arg_2 - _arg_1);
         return _local_3;
      }

      public function substr(_arg_1:uint = 0, _arg_2:uint = 4294967295):String
      {
         if (_arg_2)
         {
            return toString(_arg_1,Math.min(Number(_arg_1) + Number(_arg_2),4294967295));
         }
         return "";
      }

      public function substring(_arg_1:uint, _arg_2:uint = 4294967295):String
      {
         if (_arg_2 > _arg_1)
         {
            return toString(_arg_1,_arg_2);
         }
         return "";
      }

      public function toString(_arg_1:uint = 0, _arg_2:uint = 0):String
      {
         var _local_3:ByteArray = null;
         _local_3 = buffer;
         var _local_5:int = _local_3.position;
         if (int(!_arg_2) | int(_arg_2 > _local_5))
         {
            _arg_2 = _local_5;
         }
         if (_arg_1 >= _arg_2)
         {
            return "";
         }
         _local_3.position = _arg_1;
         var _local_4:String = _local_3.readUTFBytes(_arg_2 - _arg_1);
         _local_3.position = _local_5;
         return _local_4;
      }

      public function trimToSize(_arg_1:uint = 0):uint
      {
         var _local_2:uint = _arg_1 || uint(size());
         if (_local_2 >= buffer.length)
         {
            return buffer.length;
         }
         buffer.position = _local_2;
         buffer.length = _local_2;
         return _local_2;
      }

      public function trimToSizeVoid(_arg_1:uint = 0):StringBuffer
      {
         var _local_2:uint = _arg_1 || uint(size());
         if (_local_2 >= buffer.length)
         {
            return this;
         }
         buffer.position = _local_2;
         buffer.length = _local_2;
         return this;
      }
   }
}