package com.sulake.habbo.room.object
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDAvatarRenderManager;
    import __AS3__.vec.Vector;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
    import com.sulake.habbo.room.object.visualization.room.TileCursorVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.ResettingAnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePosterVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureHabboWheelVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureValRandomizerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBottleVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePlanetSystemVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureQueueTileVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePartyBeamerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCuboidVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCounterClockVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureWaterAreaVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureScoreBoardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureFireworksVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedFireworksVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBillboardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBackgroundVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureStickieVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureMannequinVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGuildCustomizedVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGuildIsometricBadgeVisualization;
    import com.sulake.habbo.room.object.visualization.game.SnowballVisualization;
    import com.sulake.habbo.room.object.visualization.game.SnowSplashVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVoteCounterVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVoteMajorityVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureSoundBlockVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBadgeDisplayVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureYoutubeDisplayVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureExternalImageVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBuilderPlaceholderVisualization;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.AvatarFurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.SnowballVisualizationData;
    import com.sulake.room.object.visualization.utils.GraphicAssetCollection;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomObjectVisualizationFactory extends Component implements IRoomObjectVisualizationFactory 
    {

        private var _habboAvatar:IAvatarRenderManager = null;
        private var _SafeStr_512:Map;
        private var _SafeStr_513:Boolean = true;

        public function RoomObjectVisualizationFactory(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_513 = (_arg_2 == 0);
            _SafeStr_512 = new Map();
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _habboAvatar = _arg_1;
            }, false)]));
        }

        override public function dispose():void
        {
            var _local_1:IRoomObjectVisualizationData;
            var _local_2:int;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_512 != null)
            {
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < _SafeStr_512.length)
                {
                    _local_1 = (_SafeStr_512.getWithIndex(_local_2) as IRoomObjectVisualizationData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_512.dispose();
                _SafeStr_512 = null;
            };
            super.dispose();
        }

        public function createRoomObjectVisualization(_arg_1:String):IRoomObjectGraphicVisualization
        {
            var _local_3:Class;
            switch (_arg_1)
            {
                case "room":
                    _local_3 = RoomVisualization;
                    break;
                case "tile_cursor":
                    _local_3 = TileCursorVisualization;
                    break;
                case "user":
                    _local_3 = AvatarVisualization;
                    break;
                case "bot":
                case "rentable_bot":
                    _local_3 = AvatarVisualization;
                    break;
                case "pet_animated":
                    _local_3 = AnimatedPetVisualization;
                    break;
                case "furniture_static":
                    _local_3 = FurnitureVisualization;
                    break;
                case "furniture_animated":
                    _local_3 = AnimatedFurnitureVisualization;
                    break;
                case "furniture_resetting_animated":
                    _local_3 = ResettingAnimatedFurnitureVisualization;
                    break;
                case "furniture_poster":
                    _local_3 = FurniturePosterVisualization;
                    break;
                case "furniture_habbowheel":
                    _local_3 = FurnitureHabboWheelVisualization;
                    break;
                case "furniture_val_randomizer":
                    _local_3 = FurnitureValRandomizerVisualization;
                    break;
                case "furniture_bottle":
                    _local_3 = FurnitureBottleVisualization;
                    break;
                case "furniture_planet_system":
                    _local_3 = FurniturePlanetSystemVisualization;
                    break;
                case "furniture_queue_tile":
                    _local_3 = FurnitureQueueTileVisualization;
                    break;
                case "furniture_party_beamer":
                    _local_3 = FurniturePartyBeamerVisualization;
                    break;
                case "furniture_cuboid":
                    _local_3 = FurnitureCuboidVisualization;
                    break;
                case "furniture_gift_wrapped":
                    _local_3 = FurnitureGiftWrappedVisualization;
                    break;
                case "furniture_counter_clock":
                    _local_3 = FurnitureCounterClockVisualization;
                    break;
                case "furniture_water_area":
                    _local_3 = FurnitureWaterAreaVisualization;
                    break;
                case "furniture_score_board":
                    _local_3 = FurnitureScoreBoardVisualization;
                    break;
                case "furniture_fireworks":
                    _local_3 = FurnitureFireworksVisualization;
                    break;
                case "furniture_gift_wrapped_fireworks":
                    _local_3 = FurnitureGiftWrappedFireworksVisualization;
                    break;
                case "furniture_bb":
                    _local_3 = FurnitureRoomBillboardVisualization;
                    break;
                case "furniture_bg":
                    _local_3 = FurnitureRoomBackgroundVisualization;
                    break;
                case "furniture_stickie":
                    _local_3 = FurnitureStickieVisualization;
                    break;
                case "furniture_mannequin":
                    _local_3 = FurnitureMannequinVisualization;
                    break;
                case "furniture_guild_customized":
                    _local_3 = FurnitureGuildCustomizedVisualization;
                    break;
                case "furniture_guild_isometric_badge":
                    _local_3 = FurnitureGuildIsometricBadgeVisualization;
                    break;
                case "game_snowball":
                    _local_3 = SnowballVisualization;
                    break;
                case "game_snowsplash":
                    _local_3 = SnowSplashVisualization;
                    break;
                case "furniture_vote_counter":
                    _local_3 = FurnitureVoteCounterVisualization;
                    break;
                case "furniture_vote_majority":
                    _local_3 = FurnitureVoteMajorityVisualization;
                    break;
                case "furniture_soundblock":
                    _local_3 = FurnitureSoundBlockVisualization;
                    break;
                case "furniture_badge_display":
                    _local_3 = FurnitureBadgeDisplayVisualization;
                    break;
                case "furniture_youtube":
                    _local_3 = FurnitureYoutubeDisplayVisualization;
                    break;
                case "furniture_external_image":
                    _local_3 = FurnitureExternalImageVisualization;
                    break;
                case "furniture_builder_placeholder":
                    _local_3 = FurnitureBuilderPlaceholderVisualization;
            };
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_2:Object = new _local_3();
            if ((_local_2 is IRoomObjectGraphicVisualization))
            {
                return (_local_2 as IRoomObjectGraphicVisualization);
            };
            return (null);
        }

        public function getRoomObjectVisualizationData(_arg_1:String, _arg_2:String, _arg_3:XML):IRoomObjectVisualizationData
        {
            var _local_7:IRoomObjectVisualizationData;
            var _local_6:AvatarVisualizationData;
            var _local_5:AnimatedPetVisualizationData;
            var _local_9:AvatarFurnitureVisualizationData;
            var _local_4:IRoomObjectVisualizationData;
            _local_4 = (_SafeStr_512.getValue(_arg_1) as IRoomObjectVisualizationData);
            if (_local_4 != null)
            {
                return (_local_4);
            };
            var _local_8:Class;
            switch (_arg_2)
            {
                case "furniture_static":
                case "furniture_gift_wrapped":
                case "furniture_bb":
                case "furniture_bg":
                case "furniture_stickie":
                case "furniture_builder_placeholder":
                    _local_8 = FurnitureVisualizationData;
                    break;
                case "furniture_animated":
                case "furniture_resetting_animated":
                case "furniture_poster":
                case "furniture_habbowheel":
                case "furniture_val_randomizer":
                case "furniture_bottle":
                case "furniture_planet_system":
                case "furniture_queue_tile":
                case "furniture_party_beamer":
                case "furniture_counter_clock":
                case "furniture_water_area":
                case "furniture_score_board":
                case "furniture_fireworks":
                case "furniture_gift_wrapped_fireworks":
                case "furniture_guild_customized":
                case "furniture_guild_isometric_badge":
                case "furniture_vote_counter":
                case "furniture_vote_majority":
                case "furniture_soundblock":
                case "furniture_badge_display":
                case "furniture_external_image":
                case "furniture_youtube":
                case "tile_cursor":
                    _local_8 = AnimatedFurnitureVisualizationData;
                    break;
                case "furniture_mannequin":
                    _local_8 = AvatarFurnitureVisualizationData;
                    break;
                case "room":
                    _local_8 = RoomVisualizationData;
                    break;
                case "user":
                case "bot":
                case "rentable_bot":
                    _local_8 = AvatarVisualizationData;
                    break;
                case "pet_animated":
                    _local_8 = AnimatedPetVisualizationData;
                    break;
                case "game_snowball":
                case "game_snowsplash":
                    _local_8 = SnowballVisualizationData;
            };
            if (_local_8 == null)
            {
                return (null);
            };
            _local_4 = new _local_8();
            if (_local_4 != null)
            {
                _local_7 = null;
                _local_7 = (_local_4 as IRoomObjectVisualizationData);
                if (!_local_7.initialize(_arg_3))
                {
                    _local_7.dispose();
                    return (null);
                };
                if ((_local_7 is AvatarVisualizationData))
                {
                    _local_6 = (_local_4 as AvatarVisualizationData);
                    _local_6.avatarRenderer = _habboAvatar;
                }
                else
                {
                    if ((_local_7 is AnimatedPetVisualizationData))
                    {
                        _local_5 = (_local_4 as AnimatedPetVisualizationData);
                        _local_5.commonAssets = assets;
                    }
                    else
                    {
                        if ((_local_7 is AvatarFurnitureVisualizationData))
                        {
                            _local_9 = (_local_4 as AvatarFurnitureVisualizationData);
                            _local_9.avatarRenderer = _habboAvatar;
                        }
                        else
                        {
                            if ((_local_7 is SnowballVisualizationData))
                            {
                                SnowballVisualizationData(_local_7).assets = assets;
                            };
                        };
                    };
                };
                if (_SafeStr_513)
                {
                    _SafeStr_512.add(_arg_1, _local_7);
                };
                return (_local_7);
            };
            return (null);
        }

        public function createGraphicAssetCollection():IGraphicAssetCollection
        {
            return (new GraphicAssetCollection());
        }


    }
}

