PGDMP     !    5                }         	   taleforge    15.11    15.11 e    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398 	   taleforge    DATABASE     o   CREATE DATABASE taleforge WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'zh-CN';
    DROP DATABASE taleforge;
                postgres    false            �           0    0    DATABASE taleforge    ACL     3   GRANT ALL ON DATABASE taleforge TO taleforge_user;
                   postgres    false    3500            �           0    0    SCHEMA public    ACL     .   GRANT ALL ON SCHEMA public TO taleforge_user;
                   pg_database_owner    false    5            [           1247    17394    ChapterStatus    TYPE     M   CREATE TYPE public."ChapterStatus" AS ENUM (
    'DRAFT',
    'PUBLISHED'
);
 "   DROP TYPE public."ChapterStatus";
       public          taleforge_user    false            X           1247    17384    StoryStatus    TYPE     m   CREATE TYPE public."StoryStatus" AS ENUM (
    'DRAFT',
    'PUBLISHED',
    'COMPLETED',
    'SUSPENDED'
);
     DROP TYPE public."StoryStatus";
       public          taleforge_user    false            R           1247    17367 
   SyncStatus    TYPE     i   CREATE TYPE public."SyncStatus" AS ENUM (
    'PENDING',
    'SYNCING',
    'COMPLETED',
    'FAILED'
);
    DROP TYPE public."SyncStatus";
       public          taleforge_user    false            a           1247    17408    TransactionStatus    TYPE     a   CREATE TYPE public."TransactionStatus" AS ENUM (
    'PENDING',
    'COMPLETED',
    'FAILED'
);
 &   DROP TYPE public."TransactionStatus";
       public          taleforge_user    false            ^           1247    17400    TransactionType    TYPE     _   CREATE TYPE public."TransactionType" AS ENUM (
    'PURCHASE',
    'REWARD',
    'WITHDRAW'
);
 $   DROP TYPE public."TransactionType";
       public          taleforge_user    false            U           1247    17376    UserType    TYPE     S   CREATE TYPE public."UserType" AS ENUM (
    'READER',
    'AUTHOR',
    'ADMIN'
);
    DROP TYPE public."UserType";
       public          taleforge_user    false            �            1259    17436    Chapter    TABLE     �  CREATE TABLE public."Chapter" (
    id text NOT NULL,
    title text NOT NULL,
    content text,
    "contentCid" text,
    "wordCount" integer DEFAULT 0 NOT NULL,
    "order" integer NOT NULL,
    status public."ChapterStatus" DEFAULT 'DRAFT'::public."ChapterStatus" NOT NULL,
    "txHash" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "storyId" text NOT NULL
);
    DROP TABLE public."Chapter";
       public         heap    taleforge_user    false    859    859            �            1259    17520 
   Collection    TABLE     +  CREATE TABLE public."Collection" (
    id text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    cover text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL
);
     DROP TABLE public."Collection";
       public         heap    taleforge_user    false            �            1259    17454    Comment    TABLE     :  CREATE TABLE public."Comment" (
    id text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "storyId" text,
    "chapterId" text,
    "parentId" text
);
    DROP TABLE public."Comment";
       public         heap    taleforge_user    false            �            1259    17470    CommentLike    TABLE     �   CREATE TABLE public."CommentLike" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text NOT NULL,
    "commentId" text NOT NULL
);
 !   DROP TABLE public."CommentLike";
       public         heap    taleforge_user    false            �            1259    17486    Favorite    TABLE     �   CREATE TABLE public."Favorite" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text NOT NULL,
    "storyId" text NOT NULL
);
    DROP TABLE public."Favorite";
       public         heap    taleforge_user    false            �            1259    17446    Illustration    TABLE     �   CREATE TABLE public."Illustration" (
    id text NOT NULL,
    "imageCID" text NOT NULL,
    description text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "chapterId" text NOT NULL
);
 "   DROP TABLE public."Illustration";
       public         heap    taleforge_user    false            �            1259    17478    Like    TABLE     �   CREATE TABLE public."Like" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text NOT NULL,
    "storyId" text NOT NULL
);
    DROP TABLE public."Like";
       public         heap    taleforge_user    false            �            1259    17425    Story    TABLE     6  CREATE TABLE public."Story" (
    id text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    "coverCid" text,
    "contentCid" text NOT NULL,
    "wordCount" integer DEFAULT 0 NOT NULL,
    "targetWordCount" integer DEFAULT 10000 NOT NULL,
    category text NOT NULL,
    tags text[],
    "isNFT" boolean DEFAULT false NOT NULL,
    "nftAddress" text,
    "chainId" integer,
    "authorId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Story";
       public         heap    taleforge_user    false            �            1259    17494    Transaction    TABLE     �  CREATE TABLE public."Transaction" (
    id text NOT NULL,
    type public."TransactionType" NOT NULL,
    amount text NOT NULL,
    "txHash" text NOT NULL,
    status public."TransactionStatus" DEFAULT 'PENDING'::public."TransactionStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text NOT NULL,
    "storyId" text NOT NULL
);
 !   DROP TABLE public."Transaction";
       public         heap    taleforge_user    false    865    865    862            �            1259    17415    User    TABLE     �  CREATE TABLE public."User" (
    id text NOT NULL,
    address text NOT NULL,
    type public."UserType" DEFAULT 'READER'::public."UserType" NOT NULL,
    nickname text,
    avatar text,
    bio text,
    "authorName" text,
    "isAuthor" boolean DEFAULT false NOT NULL,
    email text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."User";
       public         heap    taleforge_user    false    853    853            �            1259    17528    _CollectionToStory    TABLE     [   CREATE TABLE public."_CollectionToStory" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
 (   DROP TABLE public."_CollectionToStory";
       public         heap    taleforge_user    false            �            1259    17510    author_stories_sync    TABLE     �  CREATE TABLE public.author_stories_sync (
    id text NOT NULL,
    "authorId" text NOT NULL,
    "syncStatus" public."SyncStatus" DEFAULT 'PENDING'::public."SyncStatus" NOT NULL,
    "lastSynced" timestamp(3) without time zone,
    "errorMessage" text,
    "retryCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 '   DROP TABLE public.author_stories_sync;
       public         heap    taleforge_user    false    850    850            �            1259    17503    chain_sync_state    TABLE     �   CREATE TABLE public.chain_sync_state (
    type text NOT NULL,
    "blockNumber" integer NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 $   DROP TABLE public.chain_sync_state;
       public         heap    taleforge_user    false            �            1259    17462    follows    TABLE     �   CREATE TABLE public.follows (
    id text NOT NULL,
    "followerId" text NOT NULL,
    "followingId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.follows;
       public         heap    taleforge_user    false            �          0    17436    Chapter 
   TABLE DATA           �   COPY public."Chapter" (id, title, content, "contentCid", "wordCount", "order", status, "txHash", "createdAt", "updatedAt", "storyId") FROM stdin;
    public          taleforge_user    false    216   �       �          0    17520 
   Collection 
   TABLE DATA           i   COPY public."Collection" (id, title, description, cover, "createdAt", "updatedAt", "userId") FROM stdin;
    public          taleforge_user    false    226   ��       �          0    17454    Comment 
   TABLE DATA           x   COPY public."Comment" (id, content, "createdAt", "updatedAt", "userId", "storyId", "chapterId", "parentId") FROM stdin;
    public          taleforge_user    false    218   ��       �          0    17470    CommentLike 
   TABLE DATA           O   COPY public."CommentLike" (id, "createdAt", "userId", "commentId") FROM stdin;
    public          taleforge_user    false    220   ێ       �          0    17486    Favorite 
   TABLE DATA           J   COPY public."Favorite" (id, "createdAt", "userId", "storyId") FROM stdin;
    public          taleforge_user    false    222   ��       �          0    17446    Illustration 
   TABLE DATA           _   COPY public."Illustration" (id, "imageCID", description, "createdAt", "chapterId") FROM stdin;
    public          taleforge_user    false    217   �       �          0    17478    Like 
   TABLE DATA           F   COPY public."Like" (id, "createdAt", "userId", "storyId") FROM stdin;
    public          taleforge_user    false    221   2�       �          0    17425    Story 
   TABLE DATA           �   COPY public."Story" (id, title, description, "coverCid", "contentCid", "wordCount", "targetWordCount", category, tags, "isNFT", "nftAddress", "chainId", "authorId", "createdAt", "updatedAt") FROM stdin;
    public          taleforge_user    false    215   O�       �          0    17494    Transaction 
   TABLE DATA           m   COPY public."Transaction" (id, type, amount, "txHash", status, "createdAt", "userId", "storyId") FROM stdin;
    public          taleforge_user    false    223   !�       �          0    17415    User 
   TABLE DATA           �   COPY public."User" (id, address, type, nickname, avatar, bio, "authorName", "isAuthor", email, "createdAt", "updatedAt") FROM stdin;
    public          taleforge_user    false    214   >�       �          0    17528    _CollectionToStory 
   TABLE DATA           8   COPY public."_CollectionToStory" ("A", "B") FROM stdin;
    public          taleforge_user    false    227   �       �          0    17510    author_stories_sync 
   TABLE DATA           �   COPY public.author_stories_sync (id, "authorId", "syncStatus", "lastSynced", "errorMessage", "retryCount", "createdAt", "updatedAt") FROM stdin;
    public          taleforge_user    false    225   	�       �          0    17503    chain_sync_state 
   TABLE DATA           L   COPY public.chain_sync_state (type, "blockNumber", "updatedAt") FROM stdin;
    public          taleforge_user    false    224   ��       �          0    17462    follows 
   TABLE DATA           O   COPY public.follows (id, "followerId", "followingId", "createdAt") FROM stdin;
    public          taleforge_user    false    219   ��       �           2606    17445    Chapter Chapter_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Chapter" DROP CONSTRAINT "Chapter_pkey";
       public            taleforge_user    false    216            �           2606    17527    Collection Collection_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Collection"
    ADD CONSTRAINT "Collection_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Collection" DROP CONSTRAINT "Collection_pkey";
       public            taleforge_user    false    226            �           2606    17477    CommentLike CommentLike_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."CommentLike" DROP CONSTRAINT "CommentLike_pkey";
       public            taleforge_user    false    220            �           2606    17461    Comment Comment_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Comment" DROP CONSTRAINT "Comment_pkey";
       public            taleforge_user    false    218            �           2606    17493    Favorite Favorite_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "Favorite_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Favorite" DROP CONSTRAINT "Favorite_pkey";
       public            taleforge_user    false    222            �           2606    17453    Illustration Illustration_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Illustration"
    ADD CONSTRAINT "Illustration_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."Illustration" DROP CONSTRAINT "Illustration_pkey";
       public            taleforge_user    false    217            �           2606    17485    Like Like_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Like" DROP CONSTRAINT "Like_pkey";
       public            taleforge_user    false    221            �           2606    17435    Story Story_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Story"
    ADD CONSTRAINT "Story_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Story" DROP CONSTRAINT "Story_pkey";
       public            taleforge_user    false    215            �           2606    17502    Transaction Transaction_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT "Transaction_pkey";
       public            taleforge_user    false    223            �           2606    17424    User User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public            taleforge_user    false    214            �           2606    17534 -   _CollectionToStory _CollectionToStory_AB_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public."_CollectionToStory"
    ADD CONSTRAINT "_CollectionToStory_AB_pkey" PRIMARY KEY ("A", "B");
 [   ALTER TABLE ONLY public."_CollectionToStory" DROP CONSTRAINT "_CollectionToStory_AB_pkey";
       public            taleforge_user    false    227    227            �           2606    17519 ,   author_stories_sync author_stories_sync_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.author_stories_sync
    ADD CONSTRAINT author_stories_sync_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.author_stories_sync DROP CONSTRAINT author_stories_sync_pkey;
       public            taleforge_user    false    225            �           2606    17509 &   chain_sync_state chain_sync_state_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.chain_sync_state
    ADD CONSTRAINT chain_sync_state_pkey PRIMARY KEY (type);
 P   ALTER TABLE ONLY public.chain_sync_state DROP CONSTRAINT chain_sync_state_pkey;
       public            taleforge_user    false    224            �           2606    17469    follows follows_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.follows DROP CONSTRAINT follows_pkey;
       public            taleforge_user    false    219            �           1259    17539    Chapter_storyId_idx    INDEX     P   CREATE INDEX "Chapter_storyId_idx" ON public."Chapter" USING btree ("storyId");
 )   DROP INDEX public."Chapter_storyId_idx";
       public            taleforge_user    false    216            �           1259    17559    Collection_userId_idx    INDEX     T   CREATE INDEX "Collection_userId_idx" ON public."Collection" USING btree ("userId");
 +   DROP INDEX public."Collection_userId_idx";
       public            taleforge_user    false    226            �           1259    17547    CommentLike_commentId_idx    INDEX     \   CREATE INDEX "CommentLike_commentId_idx" ON public."CommentLike" USING btree ("commentId");
 /   DROP INDEX public."CommentLike_commentId_idx";
       public            taleforge_user    false    220            �           1259    17548     CommentLike_userId_commentId_key    INDEX     t   CREATE UNIQUE INDEX "CommentLike_userId_commentId_key" ON public."CommentLike" USING btree ("userId", "commentId");
 6   DROP INDEX public."CommentLike_userId_commentId_key";
       public            taleforge_user    false    220    220            �           1259    17546    CommentLike_userId_idx    INDEX     V   CREATE INDEX "CommentLike_userId_idx" ON public."CommentLike" USING btree ("userId");
 ,   DROP INDEX public."CommentLike_userId_idx";
       public            taleforge_user    false    220            �           1259    17543    Comment_chapterId_idx    INDEX     T   CREATE INDEX "Comment_chapterId_idx" ON public."Comment" USING btree ("chapterId");
 +   DROP INDEX public."Comment_chapterId_idx";
       public            taleforge_user    false    218            �           1259    17544    Comment_parentId_idx    INDEX     R   CREATE INDEX "Comment_parentId_idx" ON public."Comment" USING btree ("parentId");
 *   DROP INDEX public."Comment_parentId_idx";
       public            taleforge_user    false    218            �           1259    17542    Comment_storyId_idx    INDEX     P   CREATE INDEX "Comment_storyId_idx" ON public."Comment" USING btree ("storyId");
 )   DROP INDEX public."Comment_storyId_idx";
       public            taleforge_user    false    218            �           1259    17541    Comment_userId_idx    INDEX     N   CREATE INDEX "Comment_userId_idx" ON public."Comment" USING btree ("userId");
 (   DROP INDEX public."Comment_userId_idx";
       public            taleforge_user    false    218            �           1259    17553    Favorite_storyId_idx    INDEX     R   CREATE INDEX "Favorite_storyId_idx" ON public."Favorite" USING btree ("storyId");
 *   DROP INDEX public."Favorite_storyId_idx";
       public            taleforge_user    false    222            �           1259    17552    Favorite_userId_idx    INDEX     P   CREATE INDEX "Favorite_userId_idx" ON public."Favorite" USING btree ("userId");
 )   DROP INDEX public."Favorite_userId_idx";
       public            taleforge_user    false    222            �           1259    17554    Favorite_userId_storyId_key    INDEX     j   CREATE UNIQUE INDEX "Favorite_userId_storyId_key" ON public."Favorite" USING btree ("userId", "storyId");
 1   DROP INDEX public."Favorite_userId_storyId_key";
       public            taleforge_user    false    222    222            �           1259    17540    Illustration_chapterId_idx    INDEX     ^   CREATE INDEX "Illustration_chapterId_idx" ON public."Illustration" USING btree ("chapterId");
 0   DROP INDEX public."Illustration_chapterId_idx";
       public            taleforge_user    false    217            �           1259    17550    Like_storyId_idx    INDEX     J   CREATE INDEX "Like_storyId_idx" ON public."Like" USING btree ("storyId");
 &   DROP INDEX public."Like_storyId_idx";
       public            taleforge_user    false    221            �           1259    17549    Like_userId_idx    INDEX     H   CREATE INDEX "Like_userId_idx" ON public."Like" USING btree ("userId");
 %   DROP INDEX public."Like_userId_idx";
       public            taleforge_user    false    221            �           1259    17551    Like_userId_storyId_key    INDEX     b   CREATE UNIQUE INDEX "Like_userId_storyId_key" ON public."Like" USING btree ("userId", "storyId");
 -   DROP INDEX public."Like_userId_storyId_key";
       public            taleforge_user    false    221    221            �           1259    17537    Story_authorId_idx    INDEX     N   CREATE INDEX "Story_authorId_idx" ON public."Story" USING btree ("authorId");
 (   DROP INDEX public."Story_authorId_idx";
       public            taleforge_user    false    215            �           1259    17538    Story_chainId_idx    INDEX     L   CREATE INDEX "Story_chainId_idx" ON public."Story" USING btree ("chainId");
 '   DROP INDEX public."Story_chainId_idx";
       public            taleforge_user    false    215            �           1259    17556    Transaction_storyId_idx    INDEX     X   CREATE INDEX "Transaction_storyId_idx" ON public."Transaction" USING btree ("storyId");
 -   DROP INDEX public."Transaction_storyId_idx";
       public            taleforge_user    false    223            �           1259    17557    Transaction_txHash_idx    INDEX     V   CREATE INDEX "Transaction_txHash_idx" ON public."Transaction" USING btree ("txHash");
 ,   DROP INDEX public."Transaction_txHash_idx";
       public            taleforge_user    false    223            �           1259    17555    Transaction_userId_idx    INDEX     V   CREATE INDEX "Transaction_userId_idx" ON public."Transaction" USING btree ("userId");
 ,   DROP INDEX public."Transaction_userId_idx";
       public            taleforge_user    false    223            �           1259    17535    User_address_key    INDEX     O   CREATE UNIQUE INDEX "User_address_key" ON public."User" USING btree (address);
 &   DROP INDEX public."User_address_key";
       public            taleforge_user    false    214            �           1259    17536    User_authorName_key    INDEX     W   CREATE UNIQUE INDEX "User_authorName_key" ON public."User" USING btree ("authorName");
 )   DROP INDEX public."User_authorName_key";
       public            taleforge_user    false    214            �           1259    17560    _CollectionToStory_B_index    INDEX     \   CREATE INDEX "_CollectionToStory_B_index" ON public."_CollectionToStory" USING btree ("B");
 0   DROP INDEX public."_CollectionToStory_B_index";
       public            taleforge_user    false    227            �           1259    17558     author_stories_sync_authorId_key    INDEX     o   CREATE UNIQUE INDEX "author_stories_sync_authorId_key" ON public.author_stories_sync USING btree ("authorId");
 6   DROP INDEX public."author_stories_sync_authorId_key";
       public            taleforge_user    false    225            �           1259    17545 "   follows_followerId_followingId_key    INDEX     v   CREATE UNIQUE INDEX "follows_followerId_followingId_key" ON public.follows USING btree ("followerId", "followingId");
 8   DROP INDEX public."follows_followerId_followingId_key";
       public            taleforge_user    false    219    219            �           2606    17566    Chapter Chapter_storyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public."Chapter" DROP CONSTRAINT "Chapter_storyId_fkey";
       public          taleforge_user    false    215    3271    216                       2606    17651 !   Collection Collection_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Collection"
    ADD CONSTRAINT "Collection_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."Collection" DROP CONSTRAINT "Collection_userId_fkey";
       public          taleforge_user    false    226    214    3267            �           2606    17611 &   CommentLike CommentLike_commentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public."CommentLike" DROP CONSTRAINT "CommentLike_commentId_fkey";
       public          taleforge_user    false    218    3281    220                        2606    17606 #   CommentLike CommentLike_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."CommentLike" DROP CONSTRAINT "CommentLike_userId_fkey";
       public          taleforge_user    false    220    214    3267            �           2606    17586    Comment Comment_chapterId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_chapterId_fkey" FOREIGN KEY ("chapterId") REFERENCES public."Chapter"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public."Comment" DROP CONSTRAINT "Comment_chapterId_fkey";
       public          taleforge_user    false    218    3273    216            �           2606    17591    Comment Comment_parentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public."Comment" DROP CONSTRAINT "Comment_parentId_fkey";
       public          taleforge_user    false    3281    218    218            �           2606    17581    Comment Comment_storyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public."Comment" DROP CONSTRAINT "Comment_storyId_fkey";
       public          taleforge_user    false    218    3271    215            �           2606    17576    Comment Comment_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public."Comment" DROP CONSTRAINT "Comment_userId_fkey";
       public          taleforge_user    false    214    218    3267                       2606    17631    Favorite Favorite_storyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "Favorite_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."Favorite" DROP CONSTRAINT "Favorite_storyId_fkey";
       public          taleforge_user    false    3271    215    222                       2606    17626    Favorite Favorite_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "Favorite_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public."Favorite" DROP CONSTRAINT "Favorite_userId_fkey";
       public          taleforge_user    false    214    3267    222            �           2606    17571 (   Illustration Illustration_chapterId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Illustration"
    ADD CONSTRAINT "Illustration_chapterId_fkey" FOREIGN KEY ("chapterId") REFERENCES public."Chapter"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public."Illustration" DROP CONSTRAINT "Illustration_chapterId_fkey";
       public          taleforge_user    false    216    217    3273                       2606    17621    Like Like_storyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 D   ALTER TABLE ONLY public."Like" DROP CONSTRAINT "Like_storyId_fkey";
       public          taleforge_user    false    3271    215    221                       2606    17616    Like Like_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public."Like" DROP CONSTRAINT "Like_userId_fkey";
       public          taleforge_user    false    221    214    3267            �           2606    17561    Story Story_authorId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Story"
    ADD CONSTRAINT "Story_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public."Story" DROP CONSTRAINT "Story_authorId_fkey";
       public          taleforge_user    false    215    214    3267                       2606    17641 $   Transaction Transaction_storyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT "Transaction_storyId_fkey";
       public          taleforge_user    false    215    223    3271                       2606    17636 #   Transaction Transaction_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT "Transaction_userId_fkey";
       public          taleforge_user    false    3267    214    223            	           2606    17656 ,   _CollectionToStory _CollectionToStory_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_CollectionToStory"
    ADD CONSTRAINT "_CollectionToStory_A_fkey" FOREIGN KEY ("A") REFERENCES public."Collection"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."_CollectionToStory" DROP CONSTRAINT "_CollectionToStory_A_fkey";
       public          taleforge_user    false    226    227    3313            
           2606    17661 ,   _CollectionToStory _CollectionToStory_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_CollectionToStory"
    ADD CONSTRAINT "_CollectionToStory_B_fkey" FOREIGN KEY ("B") REFERENCES public."Story"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."_CollectionToStory" DROP CONSTRAINT "_CollectionToStory_B_fkey";
       public          taleforge_user    false    227    215    3271                       2606    17646 5   author_stories_sync author_stories_sync_authorId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.author_stories_sync
    ADD CONSTRAINT "author_stories_sync_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 a   ALTER TABLE ONLY public.author_stories_sync DROP CONSTRAINT "author_stories_sync_authorId_fkey";
       public          taleforge_user    false    225    214    3267            �           2606    17596    follows follows_followerId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.follows
    ADD CONSTRAINT "follows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.follows DROP CONSTRAINT "follows_followerId_fkey";
       public          taleforge_user    false    3267    214    219            �           2606    17601     follows follows_followingId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.follows
    ADD CONSTRAINT "follows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.follows DROP CONSTRAINT "follows_followingId_fkey";
       public          taleforge_user    false    214    219    3267            �   x  x�՗[O�ǟ�Oa!������6���I�&U"��4:/��Rn&�d0s� c \|L���6�.��=�~�����8J߬*�5�������o�Q%����2EQ�<>,��e�dߐ�<>f̣WN�՘C�(��X���k�SP��]�����H�_QzG_�3���>M����S4�Nh7�F���ne�Y��9��F�r*#�φ�ɋ�Ii�]�X�}�0heg�{�?�Sh��K����Лe����@��_���	_y��>~:��.]�b3Y�;���b	3Z���dEO���(qj�\��y��6�1���W%CϚ���~���uhO�J	oe൙��[As'g�-/���YM��%�����z�ڶ������\��p2٬��:+C�2X��H�UP����B�9��4&Ql���r�Գ���b��67���I�O�B�����IZ�+�Vᜬ_��i
��횦�!�rd��]��6��^X��M�d�xscG�(|;����fu��X{G�(�4�:y��Z�KdX<�"DY���f�Q�l�vPP�%�z̈́�!���F9b���.ϠI�:l������l�[G�C���>:xk�2Vp	�D�}�Xh����MCШGPb�gp4�b��=ٜ����<�
��x>���(:��t����1��&�p r�t�L������$:σ@� e賤7��^�~�� �%#.G۠�Ԭ�:!.-�@I���3��,����S}��2H��5�	��G��Q���Ch��У��D�X��-	��kҒ?#I���I��B�*�W�x�n��lF�ƟX��%�*g$;�J�ƒ�L��.����R[��b��b���l����	��tp�UȘo�� �AN�CQl�G1��F�Q�0ýDJO� �d2h�n��f(��yTΡ����t<���k3]�[�q$��/�Kٶ � fh.�¯���N����;6qa�m7W�(�,�����vA�3F=Mx� ��3����.&̕PR��R�� c�."��'�(3�`?�~u��MpT<��+��9�<�����G,����>?��n���>e������[�����1m����Ѣ�q<|r��=�w�A�k*#j��xV�xEyU�z$Y�Y^�=>Uce�*�"q>��J��Q�)���H�wSl7#8i�M�n�sq����0n�u��P��y�����G ΄w<0 ���3��@�Bz#�_���I�C�J�B�ET³���'��$��*�(VX�9
�u}�&Hk;�!���%H��V�@J@�Eȅ�r�ík�rf��^�̶W4��l�K��e��Cx,�"d��dVp��<�@�8I��7vӊ�m��N��Ŏ��'�d� z�"�u������ցL͍�}�����6�W���@XN�cП�ܑ�:��.���&�asj����1����M[�1�/��T4N㵍+�c�{�(tYɥ���	���,KW�;���Jh�����)�ޫ�Z5T��9�6�>��f#�]ٶ-�)�\#I����=������(�O�=�����B�����[�~�����uв�?@�(�AR<��(I�iVP|>�Ǩ��j
-3���#󼪈"˳�$�^��EA�I�9��]r3����F�s��3z�VO�<�+$�6�b	��>� ��+���	r��.fP�f�*�R�����L���élL��O�s�?�Չ��
�2�x�W�� ���?������}�=��/��\���{�ޖ����x����3�:X��~ ��
�O`���4�Q�^Q�M�0>�e8��}�R}��1���i>�ai��a-Ļ9�M	.I~<���<������?׍7�~h�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x�͑�j�@�ϫ���쮾V���H8����F"y%Y�+Y��Xr�!�SS(��B.�!Z(9�#Ц/c9ͩ����C��˰��w�3�Y�8�~�A%%�����ǲ,���7뛋����OW�|��}u~{v��w�.����g��?���;摉�dT,�]�4�LLc<쵧��R5k������	C��S5w�V-j:i��T�I4�{=an.�" �Y���S���@
���v>%�s5x,��P� C,nC~K[�1�#�&�!�cf�+��
�F�a��{V���M��D�K����)����ϕy�˷�}����_n^_��Ǘ�,W_��n6N�(#m]4V�1����!��E��z���O�����w��E�f�w5�;�{�h���]K뻺��6�P?F����߾ڳ�������,@ނr]$uְ�?�s5��~ֹ{      �      x������ � �      �   �   x�Kε((M�ȶ0 ˊ|��̪��B�dN�
��Dcgc3�Tssg�dSCcCcS�T7S#S�dGcSSC� WG� �?N�g�v>����tC?=���Y�Y`�d�c��^�_Z���������id`d�k`�kd�`hhedne`�gnl�K�+F��� ��2�      �      x������ � �      �   p   x�Kε((M2��4000��ȷ0���*,���L�$Vd[ e@2y�U����ɜ���>�!�.�FF��ƺFf
��VFV��z��Ɯ1~�F��V��z���84�r��qqq zg#G      �      x������ � �      �      x������ � �     