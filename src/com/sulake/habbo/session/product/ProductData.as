package com.sulake.habbo.session.product
{
    public class ProductData implements IProductData 
    {

        private var _type:String;
        private var _name:String;
        private var _description:String = "";

        public function ProductData(_arg_1:String, _arg_2:String)
        {
            _type = _arg_1;
            _name = _arg_2;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }


    }
}