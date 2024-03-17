package com.fastbee.base.util;

import java.io.Serializable;
import java.util.*;
import java.util.function.Consumer;
import java.util.function.UnaryOperator;

/**
 * @author bill
 */
public class VirtualList<E> extends AbstractList<E> implements RandomAccess, Serializable {

    private final E[] elementData;
    private final int size;

    public VirtualList(E[] array, int length) {
        this.elementData = array;
        this.size = length;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public Object[] toArray() {
        return elementData.clone();
    }

    @Override
    @SuppressWarnings("unchecked")
    public <T> T[] toArray(T[] a) {
        if (a.length < size)
            return Arrays.copyOf(this.elementData, size,
                    (Class<? extends T[]>) a.getClass());
        System.arraycopy(this.elementData, 0, a, 0, size);
        if (a.length > size)
            a[size] = null;
        return a;
    }

    @Override
    public E get(int index) {
        return elementData[index];
    }

    @Override
    public E set(int index, E element) {
        E oldValue = elementData[index];
        elementData[index] = element;
        return oldValue;
    }

    @Override
    public int indexOf(Object o) {
        E[] a = this.elementData;
        if (o == null) {
            for (int i = 0; i < size; i++)
                if (a[i] == null)
                    return i;
        } else {
            for (int i = 0; i < size; i++)
                if (o.equals(a[i]))
                    return i;
        }
        return -1;
    }

    @Override
    public boolean contains(Object o) {
        return indexOf(o) != -1;
    }

    @Override
    public Spliterator<E> spliterator() {
        return Spliterators.spliterator(elementData, 0, size, Spliterator.ORDERED);
    }

    @Override
    public void forEach(Consumer<? super E> action) {
        Objects.requireNonNull(action);
        for (int i = 0; i < size; i++) {
            action.accept(elementData[i]);
        }
    }

    @Override
    public void replaceAll(UnaryOperator<E> operator) {
        Objects.requireNonNull(operator);
        E[] a = this.elementData;
        for (int i = 0; i < size; i++) {
            a[i] = operator.apply(a[i]);
        }
    }

    @Override
    public void sort(Comparator<? super E> c) {
        Arrays.sort(elementData, 0, size, c);
    }
}