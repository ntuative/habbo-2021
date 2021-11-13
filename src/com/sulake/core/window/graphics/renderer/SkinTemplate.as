package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.ChildEntityArray;
    import com.sulake.core.assets.IAsset;

    public class SkinTemplate extends ChildEntityArray implements ISkinTemplate 
    {

        protected var _name:String;
        protected var _asset:IAsset;

        public function SkinTemplate(_arg_1:String, _arg_2:IAsset)
        {
            _name = _arg_1;
            _asset = _arg_2;
        }

        public function get id():uint
        {
            return (0);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get asset():IAsset
        {
            return (_asset);
        }

        public function dispose():void
        {
            var _local_2:uint;
            var _local_1:uint = this.numChildren;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                this.removeChildAt(0);
                _local_2++;
            };
            _asset = null;
            _name = null;
        }


    }
}