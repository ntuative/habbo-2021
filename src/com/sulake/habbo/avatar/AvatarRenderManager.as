package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.events.Event;
    import com.sulake.habbo.avatar.structure.AvatarStructureDownload;
    import com.sulake.habbo.avatar.structure.IStructureData;
    import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
    import com.sulake.core.assets.IAsset;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.IFigureSetData;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.utils.FigureDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationManager;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.iid.*;

        public class AvatarRenderManager extends Component implements IAvatarRenderManager 
    {

        private const AVATAR_PLACEHOLDER_FIGURE:String = "hd-99999-99999";

        private var _aliasCollection:AssetAliasCollection;
        private var _SafeStr_462:AvatarStructure;
        private var _mode:String;
        private var _petImageListeners:Map;
        private var _SafeStr_463:AvatarAssetDownloadManager;
        private var _SafeStr_464:EffectAssetDownloadManager;
        private var _SafeStr_470:AvatarFigureContainer;
        private var _SafeStr_466:Boolean = false;
        private var _SafeStr_467:Boolean = false;
        private var _isReady:Boolean = false;
        private var _inNuxFlow:Boolean;
        private var _SafeStr_468:Boolean;
        private var _SafeStr_465:Boolean;
        private var _SafeStr_469:Array = [];

        public function AvatarRenderManager(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary, _arg_4:Boolean=false)
        {
            _inNuxFlow = _arg_4;
            _arg_2 = (_arg_2 | 0x04);
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return ((_inNuxFlow) ? super.dependencies : super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(), null, true, [{
    "type":"complete",
    "callback":onConfigurationComplete
}])]));
        }

        override protected function initComponent():void
        {
            _mode = "component";
            _petImageListeners = new Map();
            var _local_1:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>
            ;
            _SafeStr_462 = new AvatarStructure(this);
            _SafeStr_462.initGeometry(((assets.hasAsset("HabboAvatarGeometry")) ? (assets.getAssetByName("HabboAvatarGeometry").content as XML) : null));
            _SafeStr_462.initPartSets(((assets.hasAsset("HabboAvatarPartSets")) ? (assets.getAssetByName("HabboAvatarPartSets").content as XML) : null));
            _SafeStr_462.initActions(assets, _local_1);
            _SafeStr_462.initAnimation(((assets.hasAsset("HabboAvatarAnimation")) ? (assets.getAssetByName("HabboAvatarAnimation").content as XML) : null));
            _SafeStr_462.initFigureData(((assets.hasAsset("HabboAvatarFigure")) ? (assets.getAssetByName("HabboAvatarFigure").content as XML) : null));
            _aliasCollection = new AssetAliasCollection(this, (context.assets as AssetLibraryCollection));
            _aliasCollection.init();
            checkIfReady();
        }

        private function requestActions():void
        {
            var _local_3:String = (getProperty("flash.dynamic.avatar.download.url") + "HabboAvatarActions.xml");
            var _local_1:URLRequest = new URLRequest(_local_3);
            var _local_2:AssetLoaderStruct = assets.loadAssetFromFile("HabboAvatarActions", _local_1, "text/xml");
            _local_2.addEventListener("AssetLoaderEventComplete", onAvatarActionsLoaded);
        }

        private function onAvatarActionsLoaded(_arg_1:Event=null):void
        {
            if (_SafeStr_462 == null)
            {
                return;
            };
            var _local_2:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>
            ;
            _SafeStr_462.updateActions(((assets.hasAsset("HabboAvatarActions")) ? (assets.getAssetByName("HabboAvatarActions").content as XML) : _local_2));
            _SafeStr_468 = true;
            checkIfReady();
        }

        override public function dispose():void
        {
            super.dispose();
            if (_SafeStr_462 != null)
            {
                _SafeStr_462.dispose();
                _SafeStr_462 = null;
            };
            if (_aliasCollection != null)
            {
                _aliasCollection.dispose();
                _aliasCollection = null;
            };
            if (_petImageListeners)
            {
                _petImageListeners.dispose();
                _petImageListeners = null;
            };
            if (_SafeStr_463)
            {
                _SafeStr_463.removeEventListener("complete", onAvatarAssetsDownloadManagerReady);
                _SafeStr_463.dispose();
                _SafeStr_463 = null;
            };
            if (_SafeStr_464)
            {
                _SafeStr_464.removeEventListener("complete", onAvatarAssetsDownloadManagerReady);
                _SafeStr_464.dispose();
                _SafeStr_464 = null;
            };
            _SafeStr_469 = null;
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            var _local_5:String;
            var _local_7:String;
            var _local_6:String;
            var _local_2:String;
            var _local_4:String;
            var _local_3:AvatarStructureDownload;
            requestActions();
            if (_SafeStr_462 != null)
            {
                _local_4 = getProperty("external.figurepartlist.txt");
                if (assets.hasAsset(_local_4))
                {
                    assets.removeAsset(assets.getAssetByName(_local_4));
                };
                _local_3 = new AvatarStructureDownload(assets, _local_4, (_SafeStr_462.figureData as IStructureData));
                _local_3.addEventListener("AVATAR_STRUCTURE_DONE", onFigureDataDownloadDone);
                if (_SafeStr_463 == null)
                {
                    _local_2 = getProperty("flash.dynamic.avatar.download.configuration");
                    _local_6 = getProperty("flash.dynamic.avatar.download.url");
                    _local_7 = getProperty("flash.dynamic.avatar.download.name.template");
                    _SafeStr_463 = new AvatarAssetDownloadManager(this, context.assets, _local_2, _local_6, _SafeStr_462, _local_7);
                    _SafeStr_463.addEventListener("complete", onAvatarAssetsDownloadManagerReady);
                    _SafeStr_463.addEventListener("LIBRARY_LOADED", onAvatarAssetsLibraryReady);
                };
                if (_SafeStr_464 == null)
                {
                    _local_5 = (getProperty("flash.dynamic.avatar.download.url") + "effectmap.xml");
                    _local_6 = getProperty("flash.dynamic.avatar.download.url");
                    _local_7 = getProperty("flash.dynamic.avatar.download.name.template");
                    _SafeStr_464 = new EffectAssetDownloadManager(context.assets, _local_5, _local_6, _SafeStr_462, _local_7);
                    _SafeStr_464.addEventListener("complete", onEffectAssetsDownloadManagerReady);
                    _SafeStr_464.addEventListener("LIBRARY_LOADED", onEffectAssetsLibraryReady);
                };
            };
        }

        public function onMandatoryLibrariesReady():void
        {
            checkIfReady();
        }

        private function onAvatarAssetsLibraryReady(_arg_1:LibraryLoadedEvent):void
        {
            _aliasCollection.onAvatarAssetsLibraryReady(_arg_1.library);
        }

        private function onEffectAssetsLibraryReady(_arg_1:LibraryLoadedEvent):void
        {
            _aliasCollection.onAvatarAssetsLibraryReady(_arg_1.library);
        }

        private function onFigureDataDownloadDone(_arg_1:Event=null):void
        {
            var _local_2:IAsset = assets.getAssetByName(getProperty("external.figurepartlist.txt"));
            if (_local_2)
            {
                assets.removeAsset(_local_2).dispose();
            };
            _SafeStr_467 = true;
            _SafeStr_462.init();
            checkIfReady();
        }

        private function onAvatarAssetsDownloadManagerReady(_arg_1:Event=null):void
        {
            _SafeStr_466 = true;
            checkIfReady();
        }

        private function onEffectAssetsDownloadManagerReady(_arg_1:Event=null):void
        {
            _SafeStr_465 = true;
            checkIfReady();
        }

        public function get effectMap():Dictionary
        {
            if (_SafeStr_465)
            {
                return (_SafeStr_464.map);
            };
            return (null);
        }

        private function checkIfReady():void
        {
            if (!_isReady)
            {
                if (((((_SafeStr_466) && (_SafeStr_467)) && (_SafeStr_468)) && (_SafeStr_465)))
                {
                    _isReady = true;
                    this.events.dispatchEvent(new Event("AVATAR_RENDER_READY"));
                    purgeInitDownloadBuffer();
                };
            };
        }

        private function purgeInitDownloadBuffer():void
        {
            var _local_1:IAvatarImageListener;
            if (_SafeStr_469)
            {
                for each (var _local_2:Array in _SafeStr_469)
                {
                    _local_1 = _local_2[1];
                    if (((!(_local_1 == null)) && (!(_local_1.disposed))))
                    {
                        _SafeStr_463.loadFigureSetData((_local_2[0] as IAvatarFigureContainer), _local_1);
                    };
                };
                _SafeStr_469 = [];
            };
        }

        public function createFigureContainer(_arg_1:String):IAvatarFigureContainer
        {
            return (new AvatarFigureContainer(_arg_1));
        }

        public function isFigureReady(_arg_1:IAvatarFigureContainer):Boolean
        {
            if (!_SafeStr_463)
            {
                return (false);
            };
            return (_SafeStr_463.isReady(_arg_1));
        }

        public function downloadFigure(_arg_1:IAvatarFigureContainer, _arg_2:IAvatarImageListener):void
        {
            if (!_SafeStr_463)
            {
                _SafeStr_469.push([_arg_1, _arg_2]);
                return;
            };
            _SafeStr_463.loadFigureSetData(_arg_1, _arg_2);
        }

        public function createAvatarImage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IAvatarImageListener=null, _arg_5:IAvatarEffectListener=null):IAvatarImage
        {
            var _local_6:PlaceholderAvatarImage;
            var _local_7:AvatarFigureContainer = new AvatarFigureContainer(_arg_1);
            if (_SafeStr_462 == null)
            {
                _SafeStr_469.push([_local_7, _arg_4]);
                return (null);
            };
            if (((!(_SafeStr_463)) && (!(_mode == "local_only"))))
            {
                _SafeStr_469.push([_local_7, _arg_4]);
                return (null);
            };
            if (_arg_3)
            {
                validateAvatarFigure(_local_7, _arg_3);
            };
            if (((_mode == "local_only") || (_SafeStr_463.isReady(_local_7))))
            {
                return (new AvatarImage(_SafeStr_462, _aliasCollection, _local_7, _arg_2, _SafeStr_464, _arg_5));
            };
            if (!_SafeStr_470)
            {
                _SafeStr_470 = new AvatarFigureContainer("hd-99999-99999");
            };
            _local_6 = new PlaceholderAvatarImage(_SafeStr_462, _aliasCollection, _SafeStr_470, _arg_2, _SafeStr_464);
            _SafeStr_463.loadFigureSetData(_local_7, _arg_4);
            return (_local_6);
        }

        public function getFigureData():IFigureSetData
        {
            if (_SafeStr_462)
            {
                return (_SafeStr_462.figureData);
            };
            return (null);
        }

        public function isValidFigureSetForGender(_arg_1:int, _arg_2:String):Boolean
        {
            var _local_3:IFigureSetData = getFigureData();
            var _local_4:IFigurePartSet = _local_3.getFigurePartSet(_arg_1);
            if (_local_4 != null)
            {
                if (((_local_4.gender.toUpperCase() == "U") || (_local_4.gender.toUpperCase() == _arg_2.toUpperCase())))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getFigureStringWithFigureIds(_arg_1:String, _arg_2:String, _arg_3:Vector.<int>):String
        {
            var _local_6:FigureDataContainer = new FigureDataContainer();
            _local_6.loadAvatarData(_arg_1, _arg_2);
            var _local_4:Vector.<IFigurePartSet> = resolveFigureSets(_arg_3);
            for each (var _local_5:IFigurePartSet in _local_4)
            {
                _local_6.savePartData(_local_5.type, _local_5.id, _local_6.getColourIds(_local_5.type));
            };
            return (_local_6.getFigureString());
        }

        private function resolveFigureSets(_arg_1:Vector.<int>):Vector.<IFigurePartSet>
        {
            var _local_4:IFigurePartSet;
            var _local_2:IFigureSetData = getFigureData();
            var _local_3:Vector.<IFigurePartSet> = new Vector.<IFigurePartSet>(0);
            for each (var _local_5:int in _arg_1)
            {
                _local_4 = _local_2.getFigurePartSet(_local_5);
                if (_local_4 != null)
                {
                    _local_3.push(_local_4);
                };
            };
            return (_local_3);
        }

        public function getItemIds():Array
        {
            return (_SafeStr_462.getItemIds());
        }

        public function getAnimationManager():IAnimationManager
        {
            if (_SafeStr_462)
            {
                return (_SafeStr_462.animationManager);
            };
            return (null);
        }

        public function getMandatoryAvatarPartSetIds(_arg_1:String, _arg_2:int):Array
        {
            if (_SafeStr_462)
            {
                return (_SafeStr_462.getMandatorySetTypeIds(_arg_1, _arg_2));
            };
            return (null);
        }

        public function getAssetByName(_arg_1:String):IAsset
        {
            return (_aliasCollection.getAssetByName(_arg_1));
        }

        public function get mode():String
        {
            return (_mode);
        }

        public function set mode(_arg_1:String):void
        {
            _mode = _arg_1;
        }

        public function injectFigureData(_arg_1:XML):void
        {
            if (_SafeStr_462 != null)
            {
                _SafeStr_462.injectFigureData(_arg_1);
            };
        }

        private function validateAvatarFigure(_arg_1:AvatarFigureContainer, _arg_2:String):Boolean
        {
            var _local_5:Boolean;
            var _local_3:IFigureSetData;
            var _local_7:IFigurePartSet;
            var _local_11:ISetType;
            var _local_4:IFigurePartSet;
            var _local_9:IFigurePartSet;
            if (!_SafeStr_462)
            {
                ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: structure is null!");
            };
            var _local_10:int = 2;
            var _local_6:Array = _SafeStr_462.getMandatorySetTypeIds(_arg_2, _local_10);
            if (_local_6)
            {
                _local_3 = _SafeStr_462.figureData;
                if (!_local_3)
                {
                    ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: figureData is null!");
                };
                for each (var _local_8:String in _local_6)
                {
                    if (!_arg_1.hasPartType(_local_8))
                    {
                        _local_7 = _SafeStr_462.getDefaultPartSet(_local_8, _arg_2);
                        if (_local_7)
                        {
                            _arg_1.updatePart(_local_8, _local_7.id, [0]);
                            _local_5 = true;
                        };
                    }
                    else
                    {
                        _local_11 = _local_3.getSetType(_local_8);
                        if (!_local_11)
                        {
                            ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: setType is null!");
                        };
                        _local_4 = _local_11.getPartSet(_arg_1.getPartSetId(_local_8));
                        if (!_local_4)
                        {
                            _local_9 = _SafeStr_462.getDefaultPartSet(_local_8, _arg_2);
                            if (_local_9)
                            {
                                _arg_1.updatePart(_local_8, _local_9.id, [0]);
                                _local_5 = true;
                            };
                        };
                    };
                };
            };
            return (!(_local_5));
        }

        public function resolveClubLevel(_arg_1:IAvatarFigureContainer, _arg_2:String, _arg_3:Array=null):int
        {
            var _local_15:String;
            var _local_9:ISetType;
            var _local_13:int;
            var _local_12:IFigurePartSet;
            var _local_14:IPalette;
            var _local_11:Array;
            var _local_5:IPartColor;
            var _local_6:int;
            if (!_SafeStr_462)
            {
                return (0);
            };
            var _local_10:IFigureSetData = _SafeStr_462.figureData;
            var _local_4:Array = _arg_1.getPartTypeIds();
            for each (_local_15 in _local_4)
            {
                _local_9 = _local_10.getSetType(_local_15);
                _local_13 = _arg_1.getPartSetId(_local_15);
                _local_12 = _local_9.getPartSet(_local_13);
                if (_local_12 != null)
                {
                    _local_6 = Math.max(_local_12.clubLevel, _local_6);
                    _local_14 = _local_10.getPalette(_local_9.paletteID);
                    _local_11 = _arg_1.getPartColorIds(_local_15);
                    for each (var _local_7:int in _local_11)
                    {
                        _local_5 = _local_14.getColor(_local_7);
                        _local_6 = Math.max(_local_5.clubLevel, _local_6);
                    };
                };
            };
            if (_arg_3 == null)
            {
                _arg_3 = _SafeStr_462.getBodyPartsUnordered("full");
            };
            for each (var _local_8:String in _arg_3)
            {
                _local_9 = _local_10.getSetType(_local_8);
                if (_local_4.indexOf(_local_8) == -1)
                {
                    _local_6 = Math.max(_local_9.optionalFromClubLevel(_arg_2), _local_6);
                };
            };
            return (_local_6);
        }

        public function resetAssetManager():void
        {
            _aliasCollection.reset();
        }

        public function get isReady():Boolean
        {
            return (_isReady);
        }


    }
}

