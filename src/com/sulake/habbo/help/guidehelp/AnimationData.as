package com.sulake.habbo.help.guidehelp
{
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public class AnimationData 
    {

        public var window:IStaticBitmapWrapperWindow;
        public var asset:String;
        public var frameCount:int;

        public function AnimationData(_arg_1:IStaticBitmapWrapperWindow, _arg_2:String, _arg_3:int)
        {
            this.window = _arg_1;
            this.asset = _arg_2;
            this.frameCount = _arg_3;
        }

    }
}