package
{
   import flash.utils.ByteArray;

   public class _SafeStr_10
   {
      private const _SafeStr_4575:uint = 0x0100;

      private var _SafeStr_4572:int = 0;
      private var _SafeStr_4573:int = 0;
      private var _SafeStr_4574:ByteArray;

      public function _SafeStr_10(_arg_1:ByteArray = null)
      {
         super();
         this._SafeStr_4574 = new ByteArray();
         if (_arg_1)
         {
            this._SafeStr_263(_arg_1);
         }
      }

      public function _SafeStr_4576():uint
      {
         return this._SafeStr_4575;
      }

      public function _SafeStr_263(_arg_1:ByteArray):void
      {
         var _local_2:int = 0;
         var _local_3:int = 0;
         var _local_4:int = 0;
         _local_2 = 0;
         while (_local_2 < 0x0100)
         {
            this._SafeStr_4574[_local_2] = _local_2;
            _local_2++;
         }

         _local_3 = 0;
         _local_2 = 0;
         while (_local_2 < 0x0100)
         {
            _local_3 = _local_3 + this._SafeStr_4574[_local_2] + _arg_1[_local_2 % _arg_1.length] & 255;
            _local_4 = this._SafeStr_4574[_local_2];
            this._SafeStr_4574[_local_2] = this._SafeStr_4574[_local_3];
            this._SafeStr_4574[_local_3] = _local_4;
            _local_2++;
         }
         this._SafeStr_4572 = 0;
         this._SafeStr_4573 = 0;
      }

      private function _SafeStr_4577():uint
      {
         var _local_1:int = 0;
         this._SafeStr_4572 = this._SafeStr_4572 + 1 & 255;
         this._SafeStr_4573 = this._SafeStr_4573 + this._SafeStr_4574[this._SafeStr_4572] & 255;
         _local_1 = this._SafeStr_4574[this._SafeStr_4572];
         this._SafeStr_4574[this._SafeStr_4572] = this._SafeStr_4574[this._SafeStr_4573];
         this._SafeStr_4574[this._SafeStr_4573] = _local_1;
         return this._SafeStr_4574[_local_1 + this._SafeStr_4574[this._SafeStr_4572] & 255];
      }

      public function _SafeStr_4578():uint
      {
         return 1;
      }

      public function _SafeStr_264(_arg_1:ByteArray):void
      {
         var _local_2:uint = 0;
         while (_local_2 < _arg_1.length)
         {
            var _local_3:int = _local_2++;
            _arg_1[_local_3] ^= this._SafeStr_4577();
         }
      }

      public function _SafeStr_259(_arg_1:ByteArray):void
      {
         this._SafeStr_264(_arg_1);
      }

      public function _SafeStr_4579():void
      {
         var _local_1:uint = 0;
         if (this._SafeStr_4574 != null)
         {
            _local_1 = 0;
            while (_local_1 < this._SafeStr_4574.length)
            {
               this._SafeStr_4574[_local_1] = Math.random() * 0x0100;
               _local_1++;
            }
            this._SafeStr_4574.length = 0;
            this._SafeStr_4574 = null;
         }
         this._SafeStr_4572 = 0;
         this._SafeStr_4573 = 0;
      }
   }
}