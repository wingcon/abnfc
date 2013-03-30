

# Module abnfc #
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)

Copyright (c) 2009 Anders Nygren

__Authors:__ Anders Nygren ([`anders.nygren@gmail.com`](mailto:anders.nygren@gmail.com)), Joseph Wayne Norton ([`norton@alum.mit.edu`](mailto:norton@alum.mit.edu)).

<a name="types"></a>

## Data Types ##




### <a name="type-filename">filename()</a> ###



<pre><code>
filename() = <a href="file.md#type-filename">file:filename()</a>
</code></pre>





### <a name="type-options">options()</a> ###



<pre><code>
options() = [verbose | {verbose, boolean()} | {parser, module()} | {prefix, atom()} | binary | list | {o, <a href="#type-filename">filename()</a>} | {i, <a href="#type-filename">filename()</a>} | {mod, module()} | noobj | {noobj, boolean()}]
</code></pre>





### <a name="type-text">text()</a> ###



<pre><code>
text() = string() | binary()
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#erlangcode-0">erlangcode/0</a></td><td>Scan erlang code.</td></tr><tr><td valign="top"><a href="#erlangcode_generator-1">erlangcode_generator/1</a></td><td></td></tr><tr><td valign="top"><a href="#file-1">file/1</a></td><td>Compile an ABNF file.</td></tr><tr><td valign="top"><a href="#file-2">file/2</a></td><td>Compile an ABNF file.</td></tr><tr><td valign="top"><a href="#parse-1">parse/1</a></td><td>Parse a list or binary.</td></tr><tr><td valign="top"><a href="#parse-2">parse/2</a></td><td>Parse a list or binary.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="erlangcode-0"></a>

### erlangcode/0 ###


<pre><code>
erlangcode() -&gt; fun((eof | string()) -&gt; {ok, Abs::term(), Extra::binary()})
</code></pre>

<br></br>


Scan erlang code.
<a name="erlangcode_generator-1"></a>

### erlangcode_generator/1 ###


<pre><code>
erlangcode_generator(Depth::non_neg_integer()) -&gt; fun((eof | string()) -&gt; {ok, Abs::term(), Extra::binary()})
</code></pre>

<br></br>



<a name="file-1"></a>

### file/1 ###


<pre><code>
file(File::<a href="#type-filename">filename()</a>) -&gt; ok | {ok, module()} | error
</code></pre>

<br></br>


Compile an ABNF file.
<a name="file-2"></a>

### file/2 ###


<pre><code>
file(File::<a href="#type-filename">filename()</a>, Opts::<a href="#type-options">options()</a>) -&gt; ok | {ok, module()} | {error, Rest::term()} | error
</code></pre>

<br></br>


Compile an ABNF file.
<a name="parse-1"></a>

### parse/1 ###


<pre><code>
parse(Text::<a href="#type-text">text()</a>) -&gt; {ok, AST::term(), Rest::term()}
</code></pre>

<br></br>


Parse a list or binary.
<a name="parse-2"></a>

### parse/2 ###


<pre><code>
parse(Bin::<a href="#type-text">text()</a>, Opts::<a href="#type-options">options()</a>) -&gt; {ok, AST::term(), Rest::term()}
</code></pre>

<br></br>


Parse a list or binary.
