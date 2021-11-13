package com.sulake.bootstrap
{
    import com.sulake.habbo.game.HabboGameManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboGameManagerBootstrap extends HabboGameManager 
    {

        public function HabboGameManagerBootstrap(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}