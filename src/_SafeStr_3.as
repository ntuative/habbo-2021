package
{
   import flash.utils.ByteArray;

   public class _SafeStr_3
   {

      private const _SafeStr_4585:uint = 0x0100;

      private var i:int = 0;
      private var _SafeStr_4583:int = 0;
      private var _SafeStr_4584:ByteArray;

      public function _SafeStr_3(_arg_1:ByteArray = null)
      {
         super();
         this._SafeStr_4584 = new ByteArray();
         if(_arg_1)
         {
            this._SafeStr_249(_arg_1);
         }
      }

      public function _SafeStr_4586() : uint
      {
         return this._SafeStr_4585;
      }

      public function _SafeStr_249(_arg_1:ByteArray) : void
      {
         var _local_2:int = 0;
         var _local_3:int = 0;
         var _local_4:int = 0;
         _local_2 = 0;
         while(_local_2 < 0x0100)
         {
            this._SafeStr_4584[_local_2] = _local_2;
            _local_2++;
         }
         _local_3 = 0;
         _local_2 = 0;
         while(_local_2 < 0x0100)
         {
            _local_3 = _local_3 + this._SafeStr_4584[_local_2] + _arg_1[_local_2 % _arg_1.length] & 0xFF;
            _local_4 = this._SafeStr_4584[_local_2];
            this._SafeStr_4584[_local_2] = this._SafeStr_4584[_local_3];
            this._SafeStr_4584[_local_3] = _local_4;
            _local_2++;
         }
         this.i = 0;
         this._SafeStr_4583 = 0;
      }

      private function _SafeStr_4587() : uint
      {
         var _local_1:int = 0;
         this.i = this.i + 1 & 0xFF;
         this._SafeStr_4583 = this._SafeStr_4583 + this._SafeStr_4584[this.i] & 0xFF;
         _local_1 = this._SafeStr_4584[this.i];
         this._SafeStr_4584[this.i] = this._SafeStr_4584[this._SafeStr_4583];
         this._SafeStr_4584[this._SafeStr_4583] = _local_1;
         return this._SafeStr_4584[_local_1 + this._SafeStr_4584[this.i] & 0xFF];
      }

      public function _SafeStr_4588() : uint
      {
         return 1;
      }

      public function _SafeStr_250(_arg_1:ByteArray) : void
      {
         var _local_2:uint = 0;
         while(_local_2 < _arg_1.length)
         {
            var _local_3:int = _local_2++;
            _arg_1[_local_3] ^= this._SafeStr_4587();
         }
      }

      public function _SafeStr_248(_arg_1:ByteArray) : void
      {
         this._SafeStr_250(_arg_1);
      }

      public function _SafeStr_4589() : void
      {
         var _local_1:uint = 0;
         if(this._SafeStr_4584 != null)
         {
            _local_1 = 0;
            while(_local_1 < this._SafeStr_4584.length)
            {
               this._SafeStr_4584[_local_1] = Math.random() * 0x0100;
               _local_1++;
            }
            this._SafeStr_4584.length = 0;
            this._SafeStr_4584 = null;
         }
         this.i = 0;
         this._SafeStr_4583 = 0;
      }
   }
}

