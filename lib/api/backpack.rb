class Backpack

  def initialize(size=100)
    @size = size
    @inventory = {}
    @total_inventory_quantity = 0
  end

  def change_size(new_size)
    @size = new_size
  end

  def total_inventory_quantity
    @total_inventory_quantity
  end

  def add(item, quantity)
    if has_inventory_space?(quantity)
      add_or_increment(item, quantity)
      @total_inventory_quantity += quantity
    else
      false
    end
  end

  def find(name)
    @inventory["#{name}"]
  end

  def decrement(item, quantity)
    if quantity <= @inventory["#{item.name}"]
      @inventory["#{item.name}"] -= quantity
      @total_inventory_quantity -= quantity
      if @inventory["#{item.name}"] == 0
        @inventory.delete("#{item.name}")
      end
    else
      false
    end
  end

  def remove(name)
    @inventory.delete("#{name}")
  end

  def contents
    @inventory
  end

  def space_remaining
    @size - @total_inventory_quantity
  end

  private

  def has_inventory_space?(quantity)
    (@size - (@total_inventory_quantity + quantity)) >= 0
  end

  def add_or_increment(item, quantity)
    if @inventory["#{item.name}"].nil?
      @inventory["#{item.name}"] = quantity
    else
      @inventory["#{item.name}"] += quantity
    end
  end
end
