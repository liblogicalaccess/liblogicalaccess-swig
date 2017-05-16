/* -----------------------------------------------------------------------------
 * std_list.i
 *
 * SWIG typemaps for std::list<T>
 * C# implementation
 * The C# wrapper is made to look and feel like a C# System.Collections.Generic.LinkedList<> collection.
 *
 * ----------------------------------------------------------------------------- */
 
%include <std_common.i>

%define SWIG_STD_LIST_MINIMUM_INTERNAL(CONST_REFERENCE, CTYPE...)
%typemap(csinterfaces) std::list< CTYPE > "global::System.Collections.Generic.ICollection<$typemap(cstype, CTYPE)>, global::System.Collections.Generic.IEnumerable<$typemap(cstype, CTYPE)>, global::System.Collections.IEnumerable, global::System.IDisposable"
%proxycode %{
	public $csclassname(global::System.Collections.IEnumerable c) : this() 
	{
		if (c == null)
			throw new global::System.ArgumentNullException("c");
		foreach ($typemap(cstype, CTYPE) element in c) 
		{
			this.AddLast(element);
		}
	}

	public bool IsReadOnly 
	{
		get {
			return false;
		}
	}
	
	public int Count 
	{
		get {
			return (int)size();
		}
	}
	
	private	$csclassnameNode _head;
	internal $csclassnameNode head
	{
		get {
			if (this._head == null && (int)size() > 0)
			{
				this._head = new $csclassnameNode(($typemap(cstype, CTYPE))getItem(0), 0, this);
			}
			return this._head;
		}
		set { this._head = value; }
	}
	public $csclassnameNode First
	{
		get { return this.head;	}
	}
	
	private	$csclassnameNode _tail;
	internal $csclassnameNode tail
	{
		get {
			if (this._tail == null && (int)size() > 0)
			{
				this._tail = new $csclassnameNode(($typemap(cstype, CTYPE))getItem(0), 0, this);
			}
			return this._tail;
		}
		set { this._tail = value; }
	}
	
	public $csclassnameNode Last
	{
		get { return this.tail;	}
	}
	
	public $csclassnameNode AddFirst($typemap(cstype, CTYPE) value)
	{
		push_front(value);
		$csclassnameNode	tmp = this.head;
		while (tmp != null)	{
			tmp.index++;
			tmp = tmp.next;
		}

		$csclassnameNode	toAdd = new $csclassnameNode(value, 0, this);
		toAdd.next = this.head;
		this.head.prev = toAdd;
		this.head = toAdd;
		return this.First;
	}
	
	public $csclassnameNode AddLast($typemap(cstype, CTYPE) value)
	{
		push_back(value);

		$csclassnameNode	toAdd = new $csclassnameNode(value, (int)size() - 1, this);
		toAdd.prev = this.tail;
		this.tail.next = toAdd;
		this.tail = toAdd;
		return this.Last;
	}
	
	public void Add($typemap(cstype, CTYPE) value)
	{
		this.AddLast(value);
	}
	
	public void RemoveFirst()
	{
		pop_front();
		this.head = this.head.next;
		$csclassnameNode tmp = this.head;
		while (tmp != null) {
			tmp.index--;
			tmp = tmp.next;
		}
	}

	public void RemoveLast()
	{
		pop_back();
		this.tail = this.tail.prev;
	}

	public bool Remove($typemap(cstype, CTYPE) value)
	{
		$csclassnameNode tmp = Find(value);
		return Remove(tmp);
	}

	public bool Remove($csclassnameNode node)
	{
		if (node != null)
		{
			rmvIndex(node.index);
            node.next.prev = node.prev; 
            node.prev.next = node.next;
            if (this.head == node) {
                this.head = node.next;
			} 
			else if (this.tail == node) {
				this.tail = node.prev;
			}
			return true;
		}
		return false;
	}

	public $csclassnameNode Find($typemap(cstype, CTYPE) value)
	{
		int tmpPos = find_item(value);
		$csclassnameNode tmp = this.head;
		int i = 0;

		if (tmpPos != -1) {
			while (i != tmpPos) {
				tmp = tmp.next;
				++i;
			}
			return tmp;
		}
		return null;
	}
	
	public void CopyTo($typemap(cstype, CTYPE)[] array, int index)
	{
		if (array == null)
			throw new global::System.ArgumentNullException("array");
		if (index < 0)
			throw new global::System.ArgumentOutOfRangeException("index", "Value is less than zero");
		if (array.Rank > 1)
			throw new global::System.ArgumentException("Multi dimensional array.", "array");
		$csclassnameNode current = this.First;
		for (int i=0; i < this.Count; i++)
			array.SetValue(current.Value, index+i);
			current = current.Next;
	}

	global::System.Collections.Generic.IEnumerator<$typemap(cstype, CTYPE)> global::System.Collections.Generic.IEnumerable<$typemap(cstype, CTYPE)>.GetEnumerator() 
	{
		return new $csclassnameEnumerator(this);
	}

	global::System.Collections.IEnumerator global::System.Collections.IEnumerable.GetEnumerator() 
	{
		return new $csclassnameEnumerator(this);
	}

	public $csclassnameEnumerator GetEnumerator() 
	{
		return new $csclassnameEnumerator(this);
	}
	
	public sealed class $csclassnameEnumerator : global::System.Collections.IEnumerator,
		global::System.Collections.Generic.IEnumerator<$typemap(cstype, CTYPE)>
	{
		private $csclassname collectionRef;
		private $csclassnameNode currentNode;
		private int		currentIndex;
		private object	currentObject;
		private int		currentSize;
		
		public $csclassnameEnumerator($csclassname collection)
		{
			collectionRef = collection;
			currentNode = null;
			currentIndex = -1;
			currentObject = null;
			currentSize = collectionRef.Count;
		}
		
		// Type-safe iterator Current
		public $typemap(cstype, CTYPE) Current 
		{
			get {
				if (currentIndex == -1)
					throw new global::System.InvalidOperationException("Enumeration not started.");
				if (currentIndex > currentSize - 1)
					throw new global::System.InvalidOperationException("Enumeration finished.");
				if (currentObject == null)
					throw new global::System.InvalidOperationException("Collection modified.");
				return ($typemap(cstype, CTYPE))currentObject;
			}
		}
	
		// Type-unsafe IEnumerator.Current
		object global::System.Collections.IEnumerator.Current 
		{
			get {
				return Current;
			}
		}
		
		public bool MoveNext()
		{
			int size = collectionRef.Count;

			if (currentNode == null) {
				currentIndex = collectionRef.Count + 1;
				return false;
			}
			++currentIndex;
			currentObject = currentNode.item;
            currentNode = currentNode.next;
			return true;
		}
		
		public void Reset()
		{
			currentIndex = -1;
			currentObject = null;
			if (collectionRef.Count != currentSize) {
				throw new global::System.InvalidOperationException("Collection modified.");
			}
		}
		
		public void Dispose()
		{
			currentIndex = -1;
			currentObject = null;
		}
	}
	
	public sealed class $csclassnameNode
	{
		internal $csclassname		list;
		internal $csclassnameNode	next;
		internal $csclassnameNode	prev;
		internal $typemap(cstype, CTYPE)			item;
		internal int			index;
		
		public $csclassnameNode($typemap(cstype, CTYPE) value)
		{
			this.item = value;
		}

		internal $csclassnameNode($typemap(cstype, CTYPE) value, int _index, $csclassname _list)
		{
			this.list = _list;
			this.item = value;
			this.index = _index;
		}
		
		public $csclassname List
		{
			get { return this.list; }
		}

		public $csclassnameNode Next
		{
			get {
				if (this.next == null && index + 1 < (int)this.list.size())
					this.next = new $csclassnameNode(this.list.getItem(index + 1), index + 1, this.list);
				if (index + 1 == (int)this.list.size() - 1)
					this.list.tail = this.next;
				return this.next; 
			}
		}
		
		public $csclassnameNode Previous
		{
			get { 
				if (this.prev == null && index - 1 >= 0 )
					this.prev = new $csclassnameNode(this.list.getItem(index - 1), index - 1, this.list);
				if (index - 1 == 0)
					this.list.head = this.prev;
				return this.prev;
			}
		}
		
		public $typemap(cstype, CTYPE) Value
		{
			get { return this.item; }
			set { this.item = value; }
		}
	}
%}

public:
	typedef size_t size_type;
	typedef CTYPE value_type;
	typedef CONST_REFERENCE const_reference;
	%rename(Clear) clear;
	void clear();
	void push_front(CTYPE const& x);
	void push_back(CTYPE const& x);
	void pop_front();
	void pop_back();
	size_type size() const;
	%extend {
		const CTYPE& getItem(int index) {
			std::list< CTYPE >::iterator iter = $self->begin();
			
			if (index >= 0 && index < (int)($self->size())) {
				for (int i = 0; i != index; i++)
					iter++;
				return *iter;
			} else {
				throw std::out_of_range("index");
			}
		}
		
		int find_item(CTYPE const& x) {
			std::list< CTYPE >::iterator iter = $self->begin();
			int i = 0;
			
			while (iter != $self->end() && *iter != x) {
				++iter;
				++i;
			}
			if (*iter != NULL)
				return i;
			return -1;
		}

		bool rmv(const CTYPE& value) {
			std::list< CTYPE >::iterator iter = std::find($self->begin(), $self->end(), value);
			if (iter != $self->end()) {
				$self->erase(iter);
				return true;
			}
			return false;
		}

		bool rmvIndex(int index) {
			std::list< CTYPE >::iterator iter = $self->begin();
			for (int i = 0; iter != $self->end() && i != index; i++);
			if (iter != $self->end()) {
				$self->erase(iter);
				return true;
			}
			return false;
		}
		
		bool Contains(CTYPE const& value) {
			return std::find($self->begin(), $self->end(), value) != $self->end();
		}
	}
%enddef
 
%define SWIG_STD_LIST_ENHANCED(CTYPE...)
namespace std {
  template<> class list< CTYPE > {
    SWIG_STD_LIST_MINIMUM_INTERNAL(%arg(CTYPE const&), %arg(CTYPE));
  };
}
%enddef
 
%{
#include <list>
#include <algorithm>
#include <stdexcept>
%}

%csmethodmodifiers std::list::size "private"
%csmethodmodifiers std::list::getItem "private"
%csmethodmodifiers std::list::find_item "private"
%csmethodmodifiers std::list::push_front "private"
%csmethodmodifiers std::list::push_back "private"
%csmethodmodifiers std::list::rmv "private"
%csmethodmodifiers std::list::rmvIndex "private"

namespace std {
	template<class T> 
	class list {
		SWIG_STD_LIST_MINIMUM_INTERNAL(T const&, T)
	};
	template<class T> 
	class list<T *> 
	{
		SWIG_STD_LIST_MINIMUM_INTERNAL(T *const&, T *)
	};
	template<> 
	class list<bool> {
		SWIG_STD_LIST_MINIMUM_INTERNAL(bool, bool)
	};
}
