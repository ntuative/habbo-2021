package com.codeazur.as3swf.timeline
{
    import com.codeazur.utils.StringUtils;

    public class Scene 
    {

        public var frameNumber:uint = 0;
        public var name:String;

        public function Scene(_arg_1:uint, _arg_2:String)
        {
            this.frameNumber = _arg_1;
            this.name = _arg_2;
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((StringUtils.repeat(_arg_1) + "Name: ") + name) + ", ") + "Frame: ") + frameNumber);
        }


    }
}